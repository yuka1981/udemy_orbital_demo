class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      # login user
      log_in(user)
      redirect_to user
    else
      # create error message
      flash.now[:danger] = 'Invalid email/password.'
      # 記得 render 後面加的是 string
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil

    redirect_to root_path
  end
end
