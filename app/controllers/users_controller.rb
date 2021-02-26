class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :user_signed_in?

  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes
    @recipe = Recipe.new
  end

  def index
    @users = User.all
    @user = current_user
    @recipe = Recipe.new
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:complete] = "You have updated user successfully."
      redirect_to user_path
    else
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def authenticate_user
    if @current_user == nil
      redirect_to new_user_registration_path
    end
  end



end
