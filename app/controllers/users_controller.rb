class UsersController < ApplicationController
  def initialize
    super
    @title = 'Users'
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create_user
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find params[:id]
  end


  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
