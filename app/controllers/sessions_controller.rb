class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.email_confirmed
        sign_in user
        redirect_back_or user
      else
        flash.now[:error] = 'Please activate your account by following the
        instructions in the account confirmation email you received to proceed'
        render 'new'
      end
    else
      flash.now[:danger] = 'Invalid email or password. Please try again.'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
