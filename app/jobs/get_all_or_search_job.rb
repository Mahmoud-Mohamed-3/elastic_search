# app/jobs/get_all_or_search_job.rb
require "sidekiq"

class GetAllOrSearchJob
  include Sidekiq::Job

  def perform(query = nil)
    Sidekiq.logger.info ">>>>>> Job started with query: #{query.inspect}"

    purchase_orders = if query.present?
                        PurchaseOrder.search(
                          query: {
                            bool: {
                              should: [
                                { multi_match: {
                                  query: query,
                                  fields: [
                                    "order_num", "status", "sales_channel",
                                    "payment_method"

                                  ],
                                  type: "best_fields",
                                  fuzziness: "AUTO"
                                }
                                }
                              ],
                              minimum_should_match: 1
                            }
                          },
                          size: 10000
                          # size: 10000

                        ).records.to_a
    else
                        PurchaseOrder.all.to_a
    end

    Sidekiq.logger.info ">>>>>> Found #{purchase_orders.size} purchase orders"

    cache_key = query.present? ? "purchase_orders_results_#{query}" : "purchase_orders_results_all"
    Rails.cache.write(cache_key, purchase_orders.as_json, expires_in: 2.hours)
    Sidekiq.logger.info ">>>>>> Cached #{purchase_orders.size} orders successfully"
  end
end
