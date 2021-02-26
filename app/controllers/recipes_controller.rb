class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_recipe, only: [:edit]

  def create
    @recipes = Recipe.all
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    if @recipe.save
      flash[:complete] = "Recipe was successfully created"
      redirect_to recipe_path(@recipe)
    else
      @user = current_user
      render "index"
    end
  end

  def index
    @recipes = Recipe.all
    @recipe = Recipe.new
    @user = current_user
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipes = Recipe.all
    @recipe_new = Recipe.new
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      flash[:complete] = "Recipe was successfully updated"
      redirect_to recipe_path(@recipe)
    else
      render "edit"
    end
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.delete
    redirect_to recipes_path
  end

  private
  def recipe_params
    params.require(:recipe).permit(:title, :body, :user_id)
  end

  def correct_recipe
    recipe = Recipe.find(params[:id])
    if recipe.user != current_user
      redirect_to recipes_path
    end
  end

end
