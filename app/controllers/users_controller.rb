class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      # sign_in @user
      flash[:success] = "Please confirm your email address to continue"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated successfully"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def confirm_email
    user = User.find_by(confirm_token: params[:id])
    if user
      user.email_activate
      flash[:success] = "Welcome to Tasks. Please sign in to continue."
      redirect_to signin_url
    else
      flash[:error] = "Sorry. User does not exist."
      redirect to root_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email,
                                 :password, :password_confirmation)
  end

  #Filters

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in."
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path, notice: "No access." unless current_user?(@user)
  end
end
