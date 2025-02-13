json.extract! order_items, :id, :order_item, :purchase_order_id, :item_id, :currancy, :quantitiy_added, :quantity_shipped, :price, :discount, :tax, :platform_fee, :created_at, :updated_at
json.url resource_url(order_items, format: :json)
