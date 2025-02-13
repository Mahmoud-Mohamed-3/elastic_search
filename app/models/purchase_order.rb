class PurchaseOrder < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  # Define the Elasticsearch index structure
  settings index: { number_of_shards: 1, number_of_replicas: 1 } do
    mappings dynamic: "false" do
      indexes :id, type: "integer"
      indexes :order_num, type: "keyword"
      indexes :purchase_date, type: "date"
      indexes :status, type: "keyword"
      indexes :order_total, type: "float"
      indexes :ship_to_name, type: "text"
      indexes :created_at, type: "date"
      indexes :updated_at, type: "date"
    end
  end
end
