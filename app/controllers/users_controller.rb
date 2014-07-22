class UsersController < ApplicationController
  layout "dashboard"
  before_filter :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user || @user.is_admin
      redirect_to :back, :alert => "Access denied."
    end
  end

end
