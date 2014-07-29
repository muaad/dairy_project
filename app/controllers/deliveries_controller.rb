require 'sms_gateway'
class DeliveriesController < ApplicationController
  layout "dashboard"
  before_filter :authenticate_user!
  before_action :set_delivery, only: [:show, :edit, :update, :destroy]
  # GET /deliveries
  # GET /deliveries.json
  def index
    @deliveries = Delivery.all
    @delivery = Delivery.new
  end

  # GET /deliveries/1
  # GET /deliveries/1.json
  def show
  end

  # GET /deliveries/new
  def new
    @delivery = Delivery.new
  end

  # GET /deliveries/1/edit
  def edit
  end

  # POST /deliveries
  # POST /deliveries.json
  def create
    gateway = SMSGateway.new
    @delivery = Delivery.new(delivery_params)
    @delivery.commodity_id = params[:delivery][:commodity]
    @delivery.farmer_id = params[:delivery][:farmer]
    @delivery.price = Commodity.find(@delivery.commodity_id).latest_price
    @delivery.total = delivery_params[:quantity].to_i * @delivery.price
    @delivery.user_id = current_user.id
    @delivery.paid_for = delivery_params[:paid_for] == "1"

    respond_to do |format|
      if @delivery.save
        gateway.send(@delivery.farmer.phone_number, "Hi, #{@delivery.delivered_by}. We have taken note of your delivery of #{@delivery.quantity} litres of milk and you will be dully compensated. Thanks.")
        if @delivery.paid_for
          # Payment.create! amount: @delivery.total, delivery_id: @delivery.id, farmer_id: @delivery.farmer_id, user_id: current_user.id
          pay(@delivery)
        end
        format.html { redirect_to @delivery, notice: 'Delivery was successfully created.' }
        format.json { render :show, status: :created, location: @delivery }
      else
        format.html { render :new }
        format.json { render json: @delivery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deliveries/1
  # PATCH/PUT /deliveries/1.json
  def update
    respond_to do |format|
      # if @delivery.paid_for != (delivery_params[:paid_for] == "1")
        if !@delivery.paid_for && delivery_params[:paid_for] == "1"
          pay(@delivery)
        end
      # end
      if @delivery.update(delivery_params)
        format.html { redirect_to @delivery, notice: 'Delivery was successfully updated.' }
        format.json { render :show, status: :ok, location: @delivery }
      else
        format.html { render :edit }
        format.json { render json: @delivery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deliveries/1
  # DELETE /deliveries/1.json
  def destroy
    @delivery.destroy
    respond_to do |format|
      format.html { redirect_to deliveries_url, notice: 'Delivery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def make_payment
    if current_user.is_admin
      @delivery = Delivery.find(params[:id])
      pay(@delivery)
      redirect_to @delivery, notice: "Payment has been made!"
    else
      redirect_to @delivery, alert: "You are not authorized to make payments!"
    end
  end

  def bulk_payment
    if current_user.is_admin
      Delivery.where(:paid_for => false).each do |delivery|
        pay(delivery)
      end
      redirect_to payments_path, notice: "Payments have been made!"
    else
      redirect_to delivery, alert: "You are not authorized to make payments!"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_delivery
      @delivery = Delivery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def delivery_params
      params.require(:delivery).permit(:commodity_id, :farmer_id, :quantity, :price, :total, :paid_for, :user_id)
    end
end
