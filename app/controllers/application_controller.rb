class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  helper_method :resource_name, :resource, :devise_mapping, :deliveries_per_month

  # set_current_tenant_through_filter
	# before_filter :filter_tenant_via_devise_or_params

	# def filter_tenant_via_devise_or_params
	#   if user_signed_in?
	#     account = current_user.main_account
	#     set_current_tenant(account)
	#   elsif params[:account].present?
	#     account = Account.find_by_email(params[:account])
	#     set_current_tenant(account)
	#   elsif params[:token].present?
	#     # possibly an API client
	#     account = Account.find_by_auth_token(params[:token])
	#     set_current_tenant(account)
	#   else
	#     # token authentication via API
	#     authenticate_with_http_token do |token|        
	#       account = Account.find_by_auth_token(token)
	#       set_current_tenant(account)
	#     end
	#   end
	# end

  def after_sign_in_path_for(res)
    dashboard_index_path
  end

  def after_sign_out_path_for(arg)
    root_path
  end

  def after_sign_up_path_for(resource)
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
end
