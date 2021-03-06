class PricesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_price, only: [:show, :edit, :update, :destroy]

  # GET /prices
  # GET /prices.json
  def index
    @prices = Price.all
  end

  # GET /prices/1
  # GET /prices/1.json
  def show
  end

  # GET /prices/new
  def new
    @price = Price.new
  end

  # GET /prices/1/edit
  def edit
  end

  # POST /prices
  # POST /prices.json
  def create
    @price = Price.new(price_params)
    @price.commodity_id = params[:price][:commodity]
    @price.user_id = current_user.id

    respond_to do |format|
      if current_user.is_admin
        if @price.save
          format.html { redirect_to dashboard_settings_path, notice: 'Price was successfully updated.' }
          format.json { render :show, status: :created, location: @price }
        else
          format.html { render :new }
          format.json { render json: @price.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to dashboard_settings_path, alert: 'You are not authorized to update the price!' }
      end
    end
  end

  # PATCH/PUT /prices/1
  # PATCH/PUT /prices/1.json
  def update
    respond_to do |format|
      if @price.update(price_params)
        format.html { redirect_to @price, notice: 'Price was successfully updated.' }
        format.json { render :show, status: :ok, location: @price }
      else
        format.html { render :edit }
        format.json { render json: @price.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prices/1
  # DELETE /prices/1.json
  def destroy
    @price.destroy
    respond_to do |format|
      format.html { redirect_to prices_url, notice: 'Price was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_price
      @price = Price.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def price_params
      params.require(:price).permit(:commodity_id, :price, :user_id)
    end
end
