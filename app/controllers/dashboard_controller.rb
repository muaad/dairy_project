class DashboardController < ApplicationController
  layout "dashboard"
  before_filter :authenticate_user!
  def index
  end

  def farmers
  	@farmer = Farmer.new
  	@farmers = Farmer.all
  end

  def farmer
  	@farmer = Farmer.find(params[:id])
  end

  def delivery
  	# @delivery = Delivery.find(params[:id])
  end

  def deliveries
  	@delivery = Delivery.new
  	@deliveries = Delivery.all
  end

  def settings
    @commodity = Commodity.new
    @commodities = Commodity.all
    @price = Price.new
  end

  def reports
    
  end

  def users
  end

  def notifications
  	@deliveries = Delivery.where(paid_for: false)
  end
end