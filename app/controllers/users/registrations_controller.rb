class Users::RegistrationsController < Devise::RegistrationsController
	before_filter :configure_permitted_parameters, if: :devise_controller?


	def create
		super
		if resource.valid?

			user = User.find(resource.id)
			account = Account.create! email: user.email
			user.is_admin = true
			user.account_id = account.id
			user.save!

			
			UserAccount.create! user_id: user.id, account_id: account.id
			sign_in resource			
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