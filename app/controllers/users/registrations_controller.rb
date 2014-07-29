class Users::RegistrationsController < Devise::RegistrationsController
	before_filter :configure_permitted_parameters, if: :devise_controller?


	def create
		build_resource(sign_up_params)
		resource_saved = resource.save

		yield resource if block_given?
	    if resource_saved
	      user = User.find(resource.id)
	      account = Account.create! email: user.email
	      user.is_admin = true
	      # user.account_id = account.id
	      user.save!
	      UserAccount.create! user_id: user.id, account_id: account.id
	      respond_with resource, :location => edit_account_path(account)
	      if resource.active_for_authentication?
	        set_flash_message :notice, :signed_up if is_flashing_format?
	        sign_up(resource_name, resource)
	        # respond_with resource, location: after_sign_up_path_for(resource)
	      else
	        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
	        expire_data_after_sign_in!
	        respond_with resource, location: after_inactive_sign_up_path_for(resource)
	      end
	    else
	      clean_up_passwords resource
	      respond_with resource
	    end
	end	

	protected

		# def after_sign_up_path_for(resource)
	 #    	new_account_path
	 #  	end

	    # def configure_permitted_parameters
	    #   devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password) }
	    # end

	    def after_update_path_for(resource)
          dashboard_path
        end
end