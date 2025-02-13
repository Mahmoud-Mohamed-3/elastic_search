require 'faker'

# Seed Items
30.times do
  Item.find_or_create_by!(
    sku: Faker::Barcode.ean
  ) do |item|
    item.title = Faker::Commerce.product_name
    item.nickname = Faker::Commerce.promotion_code
    item.price = Faker::Commerce.price(range: 0..100.0)
    item.inventory = Faker::Number.between(from: 0, to: 100)
    item.fulfillment_fee = Faker::Commerce.price(range: 0..10.0)
    item.unit_cost = Faker::Commerce.price(range: 0..50.0)
  end
end

# Seed Purchase Orders
5000.times do
  purchase_date = Faker::Date.between(from: 2.years.ago, to: Date.today)
  order_type = %w[Confirmed Shipped Unshipped].sample

  PurchaseOrder.create!(
    order_num: Faker::Invoice.reference,
    purchase_date: purchase_date,
    status: order_type,
    sales_channel: %w[Online Retail Wholesale].sample,
    order_total: Faker::Commerce.price(range: 0..1000.0),
    num_items_shipped: Faker::Number.between(from: 0, to: 100),
    num_items_unshipped: Faker::Number.between(from: 0, to: 100),
    payment_method: 'CC',
    shipped_at: purchase_date + rand(1..30).days,
    shipping_price: Faker::Commerce.price(range: 0..100.0),
    shipping_tax: Faker::Commerce.price(range: 0..10.0),
    carrier: Faker::Company.name,
    tracking_number: Faker::Number.number(digits: 10),
    estimated_arrival_date: purchase_date + rand(5..50).days,
    fulfillment_center: Faker::Company.name,
    confirmed_at: purchase_date + rand(1..10).days,
    returned_date: [ nil, Faker::Date.between(from: purchase_date, to: Date.today) ].sample,
    return_reason: [ nil, Faker::Lorem.sentence ].sample,
    notes: Faker::Lorem.paragraph,
    returned_at: [ nil, Faker::Date.between(from: purchase_date, to: Date.today) ].sample,
    ship_to_name: Faker::Name.name,
    ship_to_address: Faker::Address.full_address
  )
end

# Ensure we have items and purchase orders before seeding OrderItems
items = Item.all
orders = PurchaseOrder.all

if items.any? && orders.any?
  10_000.times do
    OrderItem.create!(
      purchase_order_id: orders.sample.id,
      item_id: items.sample.id,
      currency: Faker::Currency.code,
      quantity_ordered: Faker::Number.between(from: 1, to: 10),
      quantity_shipped: Faker::Number.between(from: 0, to: 10), # Allow 0 shipped for pending orders
      price: Faker::Commerce.price(range: 0..100.0),
      discount: Faker::Commerce.price(range: 0..10.0),
      tax: Faker::Commerce.price(range: 0..10.0),
      platform_fee: Faker::Commerce.price(range: 0..10.0)
    )
  end
else
  puts "Skipping OrderItem seeding: No items or purchase orders found."
end
