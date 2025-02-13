require "test_helper"

class ResourcesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order_items = resources(:one)
  end

  test "should get index" do
    get resources_url
    assert_response :success
  end

  test "should get new" do
    get new_resource_url
    assert_response :success
  end

  test "should create order_items" do
    assert_difference("OrderItems.count") do
      post resources_url, params: { order_items: { currancy: @order_items.currancy, discount: @order_items.discount, item_id: @order_items.item_id, order_item: @order_items.order_item, platform_fee: @order_items.platform_fee, price: @order_items.price, purchase_order_id: @order_items.purchase_order_id, quantitiy_added: @order_items.quantitiy_added, quantity_shipped: @order_items.quantity_shipped, tax: @order_items.tax } }
    end

    assert_redirected_to resource_url(OrderItems.last)
  end

  test "should show order_items" do
    get resource_url(@order_items)
    assert_response :success
  end

  test "should get edit" do
    get edit_resource_url(@order_items)
    assert_response :success
  end

  test "should update order_items" do
    patch resource_url(@order_items), params: { order_items: { currancy: @order_items.currancy, discount: @order_items.discount, item_id: @order_items.item_id, order_item: @order_items.order_item, platform_fee: @order_items.platform_fee, price: @order_items.price, purchase_order_id: @order_items.purchase_order_id, quantitiy_added: @order_items.quantitiy_added, quantity_shipped: @order_items.quantity_shipped, tax: @order_items.tax } }
    assert_redirected_to resource_url(@order_items)
  end

  test "should destroy order_items" do
    assert_difference("OrderItems.count", -1) do
      delete resource_url(@order_items)
    end

    assert_redirected_to resources_url
  end
end
