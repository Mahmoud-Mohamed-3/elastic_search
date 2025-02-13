class OrderItemsController < ApplicationController
  before_action :set_resource, only: %i[ show edit update destroy ]

  # GET /OrderItems or /OrderItems.json
  def index
    @order_items = OrderItem.all
  end

  # GET /OrderItems/1 or /OrderItems/1.json
  def show
  end

  # GET /OrderItems/new
  def new
    @order_items = OrderItems.new
  end

  # GET /OrderItems/1/edit
  def edit
  end

  # POST /OrderItems or /OrderItems.json
  def create
    @order_items = OrderItems.new(resource_params)

    respond_to do |format|
      if @order_items.save
        format.html { redirect_to @order_items, notice: "OrderItems was successfully created." }
        format.json { render :show, status: :created, location: @order_items }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order_items.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /OrderItems/1 or /OrderItems/1.json
  def update
    respond_to do |format|
      if @order_items.update(resource_params)
        format.html { redirect_to @order_items, notice: "OrderItems was successfully updated." }
        format.json { render :show, status: :ok, location: @order_items }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order_items.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /OrderItems/1 or /OrderItems/1.json
  def destroy
    @order_items.destroy!

    respond_to do |format|
      format.html { redirect_to resources_path, status: :see_other, notice: "OrderItems was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resource
      @order_items = OrderItems.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def resource_params
      params.expect(order_items: [ :order_item, :purchase_order_id, :item_id, :currancy, :quantitiy_added, :quantity_shipped, :price, :discount, :tax, :platform_fee ])
    end
end
