class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[index edit update destroy]
  before_action :correct_user, only: %i[edit update]
  before_action :admin_user, only: %i[destroy]

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @snapshots = @user.snapshots.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user) # create successfully user, direct the page to show user profile

      flash[:success] = 'Welcome to Orbit.'
      redirect_to(@user)
    else
      render('new')
    end
  end

  def edit
    # @user = User.find(params[:id])
  end

  def update
    # @user = User.find(params[:id])
    if @user.update(user_params)
      # handle a successful update
      flash[:sucess] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to users_path
  end

  private

  # Move to application controller
  # def logged_in_user
  #   return if logged_in?

  #   store_location
  #   flash[:danger] = 'Please log in.'
  #   redirect_to login_url
  # end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
