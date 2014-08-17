require "payment_service"
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  helper_method :resource_name, :resource, :devise_mapping, :deliveries_per_month

  set_current_tenant_through_filter
	before_filter :set_tennant

	def set_tennant
	  if user_signed_in?
	    account = current_user.accounts.first
	    set_current_tenant(account)
	  end
	end

  def after_sign_in_path_for(res)
    dashboard_index_path
  end

  def after_sign_out_path_for(arg)
    new_user_session_path
  end

  def after_sign_up_path_for(resource)
    dashboard_index_path
  end

  def after_update_path_for(resource)
    dashboard_index_path
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
   @devise_mapping ||= Devise.mappings[:user]
  end

  def deliveries_per_month
  	# delivery = Delivery.where("created_at > ? AND created_at < ?", Time.now.beginning_of_month, Time.now.end_of_month)
  	# delivery.pluck("quantity").inject(:+)
  	
  end

  def price_trends
  	
  end


	def configure_permitted_parameters
	  devise_parameter_sanitizer.for(:sign_up) { |u| 
	  	u.permit(:name, :email, :password, :profile_pic,:is_admin) 
	  }
	  devise_parameter_sanitizer.for(:account_update) << :name
	  devise_parameter_sanitizer.for(:account_update) << :profile_pic
	  devise_parameter_sanitizer.for(:account_update) << :is_admin
	end

	def generate_unique_registration_number
	    cs = [*'0'..'9', *'a'..'z', *'A'..'Z']-['O']-['I']-['1']-['0']-['i']-['o']
		6.times.map { cs.sample }.join.upcase
	end

  def generate_random_password
    cs = [*'0'..'9', *'a'..'z', *'a'..'z']-['O']-['I']-['1']-['0']-['i']-['o']
    8.times.map { cs.sample }.join.upcase
  end

  def generate_random_trace
    cs = [*'0'..'9', *'a'..'z', *'a'..'z']-['O']-['I']-['1']-['0']-['i']-['o']
    5.times.map { cs.sample }.join.downcase
  end

  def add_user_to_account
    UserAccount.create! user_id: @user.id, account_id: current_user.accounts.first.id
  end

  def pay delivery
    gateway = SMSGateway.new
    payment = PaymentService.new
    trace = generate_random_trace
    delivery.paid_for = true
    delivery.save!
    response = payment.prepare_payment trace, delivery.total, delivery.farmer.phone_number
    transaction_code = response.to_array[0][:prepare_payment_response][:prepare_payment_result][:transaction_id]
    
    p = Payment.create! amount: delivery.total, delivery_id: delivery.id, farmer_id: delivery.farmer_id, user_id: current_user.id, transaction_number: transaction_code, trace: trace
    gateway.send(delivery.farmer.phone_number, "Hi, #{delivery.delivered_by}. We have sent you KES #{delivery.total} for your delivery of #{delivery.quantity} litres of milk. Thanks.")
    p
  end
end
