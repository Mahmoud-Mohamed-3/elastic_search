class PurchaseOrder < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  # Define the Elasticsearch index structure
  # settings index: { number_of_shards: 1, number_of_replicas: 1 } do
  #   mappings dynamic: "false" do
  #     indexes :id, type: "integer"
  #     indexes :order_num, type: "keyword"
  #     indexes :purchase_date, type: "date"
  #     indexes :status, type: "keyword"
  #     indexes :order_total, type: "float"
  #     indexes :ship_to_name, type: "text"
  #     indexes :created_at, type: "date"
  #     indexes :updated_at, type: "date"
  #   end
  # end

  settings index: { number_of_shards: 1, number_of_replicas: 0 } do
    settings analysis: {
      normalizer: {
        lowercase_normalizer: {
          type: "custom",
          filter: [ "lowercase" ]
        }
      }
    }

    mappings dynamic: "false" do
      indexes :status, type: "keyword", copy_to: "all_fields", fields: {
        lower: { type: "keyword", normalizer: "lowercase_normalizer" }
      }
      indexes :sales_channel, type: "keyword", copy_to: "all_fields"
      indexes :search_all, type: "text", analyzer: "standard"
    end
  end
end
