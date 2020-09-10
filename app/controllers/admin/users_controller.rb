class Admin::UsersController < ApplicationController
  def initialize
    super
    @title = 'Users'
  end

  def index
    @pagy, @users = pagy(filter, items: 10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if(@user.update_attributes(user_update_params))
      redirect_to admin_users_path
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to admin_users_path
  end


  private

  def filter
    p params
    @users = User.select("*")
    if(params[:email].present?)
      @users.where("email like %#{params[:email]}%")
    end
    return @users
  end

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def user_update_params
    if(params[:password].blank? && params[:password_confirmation].blank?)
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    params.permit(:email, :password, :password_confirmation)
  end
end
