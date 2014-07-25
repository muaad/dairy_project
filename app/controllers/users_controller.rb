class UsersController < ApplicationController
  layout "dashboard"
  before_filter :is_user_admin?, only: [:create, :update, :destroy]
  before_filter :authenticate_user!

  def index
    @new_user = User.new
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @deliveries = @user.deliveries
    @farmers = @user.farmers
    @payments = @user.payments
    unless @user == current_user || current_user.is_admin
      redirect_to :back, :alert => "Access denied."
    end
  end

  def create
    @user = User.new(user_params)
    @user.password = "12345678"#generate_random_password
    puts "Password >>>>>>>>>>>>> #{@user.password}"

    respond_to do |format|
      if @user.save
        begin
          @user.account_id = current_user.accounts.first.id
          UserAccount.create! account_id: current_user.accounts.first.id, user_id: @user.id
        rescue ActsAsTenant::Errors::TenantIsImmutable => e
          # puts ">>>>>>>>>> Something wrong here #{e.backtrace}"
        end
        format.html { redirect_to users_path, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { redirect_to users_path, alert: "User could not be added!" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    
  end

  private
    def is_user_admin?
      unless current_user.is_admin
        redirect_to users_path, alert: "You are not authorized to add users!"
      end
    end

  def user_params
    params.require(:user).permit(:name, :email, :password, :is_admin, :account_id)
  end
end
