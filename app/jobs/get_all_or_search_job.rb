# app/jobs/get_all_or_search_job.rb
require "sidekiq"

class GetAllOrSearchJob
  include Sidekiq::Job

  def perform(query = nil)
    Sidekiq.logger.info ">>>>>> Job started with query: #{query.inspect}"


    purchase_orders = if query.present?
                        if %w[unshipped shipped confirmed].include?(query.downcase)
                          PurchaseOrder.search(
                            query: {
                              bool: {
                                should: [
                                  {
                                    match: {
                                      "status.lower" => {
                                        query: query.downcase,
                                        fuzziness: 1,
                                        prefix_length: 2
                                      }
                                    }
                                  }
                                ],
                                minimum_should_match: 1
                              }
                            },
                            size: 10000
                          ).records.to_a

                        else
                          PurchaseOrder.search(
                            query: {
                              bool: {
                                should: [
                                  {
                                    multi_match: {
                                      query: query,
                                      fields: [ "sales_channel" ],
                                      fuzziness: "AUTO",
                                      type: "best_fields"
                                    }
                                  }
                                ],
                                minimum_should_match: 1
                              }
                            },
                            size: 10000
                          ).records.to_a
                        end
    else
                        PurchaseOrder.all.to_a
    end


    Sidekiq.logger.info ">>>>>> Found #{purchase_orders.size} purchase orders"

    cache_key = query.present? ? "purchase_orders_results_#{query}" : "purchase_orders_results_all"
    Rails.cache.write(cache_key, purchase_orders.as_json(only: [ :id, :status, :sales_channel ]), expires_in: 2.hours)

    Sidekiq.logger.info ">>>>>> Cached #{purchase_orders.size} orders successfully"
  end
end


# purchase_orders = if query.present?
#                     if [ "unshipped", "shipped", "confirmed" ].include?(query.downcase)
#                       PurchaseOrder.search(
#                         query: {
#                           bool: {
#                             filter: [
#                               { term: { "status.lower" => query.downcase } }
#                             ]
#                           }
#                         },
#                         size: 10000
#                       ).records.to_a
#                     else
#                       PurchaseOrder.search(
#                         query: {
#                           bool: {
#                             should: [
#                               {
#                                 multi_match: {
#                                   query: query,
#                                   fields: [ "sales_channel", "status.lower" ],
#                                   fuzziness: "AUTO",
#                                   type: "best_fields"
#                                 }
#                               }
#                             ],
#                             minimum_should_match: 1
#                           }
#                         },
#                         size: 10000
#                       ).records.to_a
#                     end
#                   else
#                     PurchaseOrder.all.to_a
#                   end
