class PurchaseOrdersController < ApplicationController
  before_action :set_purchase_order, only: %i[ show edit update destroy ]
  # include Searchable
  # GET /purchase_orders or /purchase_orders.json
  # def index
  #   @purchase_orders = PurchaseOrder.all.limit(100)
  # app/controllers/purchase_orders_controller.rb
  def index
    query = params[:q].presence
    cache_key = query.present? ? "purchase_orders_results_#{query}" : "purchase_orders_results_all"
    GetAllOrSearchJob.perform_async(query)
    timeout = 10
    interval = 1
    elapsed_time = 0
    loop do
      cached_result = Rails.cache.read(cache_key)
      if cached_result.is_a?(Array)
        @purchase_orders = cached_result.map { |po| PurchaseOrder.new(po) }
        break
      end
      sleep(interval)
      elapsed_time += interval
      break if elapsed_time >= timeout
    end

    Rails.logger.info ">>>>>> Retrieved #{@purchase_orders&.size || 0} orders from cache"
    @purchase_orders ||= []
  end



  # end

  # GET /purchase_orders/1 or /purchase_orders/1.json
  def show
    @purchase_order = PurchaseOrder.find(params[:id])
  end

  # GET /purchase_orders/new
  def new
    @purchase_order = PurchaseOrder.new
  end

  # GET /purchase_orders/1/edit
  def edit
  end

  # POST /purchase_orders or /purchase_orders.json
  def create
    @purchase_order = PurchaseOrder.new(purchase_order_params)

    respond_to do |format|
      if @purchase_order.save
        format.html { redirect_to @purchase_order, notice: "Purchase order was successfully created." }
        format.json { render :show, status: :created, location: @purchase_order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @purchase_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchase_orders/1 or /purchase_orders/1.json
  def update
    respond_to do |format|
      if @purchase_order.update(purchase_order_params)
        format.html { redirect_to @purchase_order, notice: "Purchase order was successfully updated." }
        format.json { render :show, status: :ok, location: @purchase_order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @purchase_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchase_orders/1 or /purchase_orders/1.json
  def destroy
    @purchase_order.destroy!

    respond_to do |format|
      format.html { redirect_to purchase_orders_path, status: :see_other, notice: "Purchase order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_order
      @purchase_order = PurchaseOrder.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def purchase_order_params
      params.expect(purchase_order: [ :order_num, :purchase_date, :status, :sales_channel, :order_total, :num_items_shipped, :num_items_unshipped, :payment_method, :shipped_at, :shipping_price, :shipping_tax, :carrier, :tracking_number, :estimated_arrival_date, :fulfillment_center, :confirmed_at, :returned_date, :return_reason, :returned_at, :ship_to_name, :ship_to_address ])
    end
end
