class OrderItem < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  belongs_to :purchase_order
  # belongs_to :item
end
