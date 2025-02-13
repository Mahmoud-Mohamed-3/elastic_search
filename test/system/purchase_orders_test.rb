require "application_system_test_case"

class PurchaseOrdersTest < ApplicationSystemTestCase
  setup do
    @purchase_order = purchase_orders(:one)
  end

  test "visiting the index" do
    visit purchase_orders_url
    assert_selector "h1", text: "Purchase orders"
  end

  test "should create purchase order" do
    visit purchase_orders_url
    click_on "New purchase order"

    fill_in "Carrier", with: @purchase_order.carrier
    fill_in "Confirmed at", with: @purchase_order.confirmed_at
    fill_in "Estimated arrival date", with: @purchase_order.estimated_arrival_date
    fill_in "Fulfillment center", with: @purchase_order.fulfillment_center
    fill_in "Num items shipped", with: @purchase_order.num_items_shipped
    fill_in "Num items unshipped", with: @purchase_order.num_items_unshipped
    fill_in "Order num", with: @purchase_order.order_num
    fill_in "Order total", with: @purchase_order.order_total
    fill_in "Payment method", with: @purchase_order.payment_method
    fill_in "Purchase date", with: @purchase_order.purchase_date
    fill_in "Return reason", with: @purchase_order.return_reason
    fill_in "Returned at", with: @purchase_order.returned_at
    fill_in "Returned date", with: @purchase_order.returned_date
    fill_in "Sales channel", with: @purchase_order.sales_channel
    fill_in "Ship to address", with: @purchase_order.ship_to_address
    fill_in "Ship to name", with: @purchase_order.ship_to_name
    fill_in "Shipped at", with: @purchase_order.shipped_at
    fill_in "Shipping price", with: @purchase_order.shipping_price
    fill_in "Shipping tax", with: @purchase_order.shipping_tax
    fill_in "Status", with: @purchase_order.status
    fill_in "Tracking number", with: @purchase_order.tracking_number
    click_on "Create Purchase order"

    assert_text "Purchase order was successfully created"
    click_on "Back"
  end

  test "should update Purchase order" do
    visit purchase_order_url(@purchase_order)
    click_on "Edit this purchase order", match: :first

    fill_in "Carrier", with: @purchase_order.carrier
    fill_in "Confirmed at", with: @purchase_order.confirmed_at.to_s
    fill_in "Estimated arrival date", with: @purchase_order.estimated_arrival_date.to_s
    fill_in "Fulfillment center", with: @purchase_order.fulfillment_center
    fill_in "Num items shipped", with: @purchase_order.num_items_shipped
    fill_in "Num items unshipped", with: @purchase_order.num_items_unshipped
    fill_in "Order num", with: @purchase_order.order_num
    fill_in "Order total", with: @purchase_order.order_total
    fill_in "Payment method", with: @purchase_order.payment_method
    fill_in "Purchase date", with: @purchase_order.purchase_date.to_s
    fill_in "Return reason", with: @purchase_order.return_reason
    fill_in "Returned at", with: @purchase_order.returned_at.to_s
    fill_in "Returned date", with: @purchase_order.returned_date.to_s
    fill_in "Sales channel", with: @purchase_order.sales_channel
    fill_in "Ship to address", with: @purchase_order.ship_to_address
    fill_in "Ship to name", with: @purchase_order.ship_to_name
    fill_in "Shipped at", with: @purchase_order.shipped_at.to_s
    fill_in "Shipping price", with: @purchase_order.shipping_price
    fill_in "Shipping tax", with: @purchase_order.shipping_tax
    fill_in "Status", with: @purchase_order.status
    fill_in "Tracking number", with: @purchase_order.tracking_number
    click_on "Update Purchase order"

    assert_text "Purchase order was successfully updated"
    click_on "Back"
  end

  test "should destroy Purchase order" do
    visit purchase_order_url(@purchase_order)
    click_on "Destroy this purchase order", match: :first

    assert_text "Purchase order was successfully destroyed"
  end
end
