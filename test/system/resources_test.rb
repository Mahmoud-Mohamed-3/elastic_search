require "application_system_test_case"

class ResourcesTest < ApplicationSystemTestCase
  setup do
    @order_items = resources(:one)
  end

  test "visiting the index" do
    visit resources_url
    assert_selector "h1", text: "Resources"
  end

  test "should create order_items" do
    visit resources_url
    click_on "New order_items"

    fill_in "Currancy", with: @order_items.currancy
    fill_in "Discount", with: @order_items.discount
    fill_in "Item", with: @order_items.item_id
    fill_in "Order item", with: @order_items.order_item
    fill_in "Platform fee", with: @order_items.platform_fee
    fill_in "Price", with: @order_items.price
    fill_in "Purchase order", with: @order_items.purchase_order_id
    fill_in "Quantitiy added", with: @order_items.quantitiy_added
    fill_in "Quantity shipped", with: @order_items.quantity_shipped
    fill_in "Tax", with: @order_items.tax
    click_on "Create OrderItems"

    assert_text "OrderItems was successfully created"
    click_on "Back"
  end

  test "should update OrderItems" do
    visit resource_url(@order_items)
    click_on "Edit this order_items", match: :first

    fill_in "Currancy", with: @order_items.currancy
    fill_in "Discount", with: @order_items.discount
    fill_in "Item", with: @order_items.item_id
    fill_in "Order item", with: @order_items.order_item
    fill_in "Platform fee", with: @order_items.platform_fee
    fill_in "Price", with: @order_items.price
    fill_in "Purchase order", with: @order_items.purchase_order_id
    fill_in "Quantitiy added", with: @order_items.quantitiy_added
    fill_in "Quantity shipped", with: @order_items.quantity_shipped
    fill_in "Tax", with: @order_items.tax
    click_on "Update OrderItems"

    assert_text "OrderItems was successfully updated"
    click_on "Back"
  end

  test "should destroy OrderItems" do
    visit resource_url(@order_items)
    click_on "Destroy this order_items", match: :first

    assert_text "OrderItems was successfully destroyed"
  end
end
