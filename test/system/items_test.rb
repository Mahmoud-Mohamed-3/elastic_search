require "application_system_test_case"

class ItemsTest < ApplicationSystemTestCase
  setup do
    @item = items(:one)
  end

  test "visiting the index" do
    visit items_url
    assert_selector "h1", text: "Items"
  end

  test "should create item" do
    visit items_url
    click_on "New item"

    fill_in "Fulfillment fee", with: @item.fulfillment_fee
    fill_in "Inventory", with: @item.inventory
    fill_in "Nickname", with: @item.nickname
    fill_in "Price", with: @item.price
    fill_in "Sku", with: @item.sku
    fill_in "Title", with: @item.title
    fill_in "Unit cost", with: @item.unit_cost
    click_on "Create Item"

    assert_text "Item was successfully created"
    click_on "Back"
  end

  test "should update Item" do
    visit item_url(@item)
    click_on "Edit this item", match: :first

    fill_in "Fulfillment fee", with: @item.fulfillment_fee
    fill_in "Inventory", with: @item.inventory
    fill_in "Nickname", with: @item.nickname
    fill_in "Price", with: @item.price
    fill_in "Sku", with: @item.sku
    fill_in "Title", with: @item.title
    fill_in "Unit cost", with: @item.unit_cost
    click_on "Update Item"

    assert_text "Item was successfully updated"
    click_on "Back"
  end

  test "should destroy Item" do
    visit item_url(@item)
    click_on "Destroy this item", match: :first

    assert_text "Item was successfully destroyed"
  end
end
