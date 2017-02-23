class Admin::CategoriesController < ApplicationController
  before_filter :authenticate_user!, :ensure_admin
  before_filter :find_category, only: [:edit, :update, :destroy]

  add_breadcrumb 'Admin Dashboard', :admin_path
  add_breadcrumb 'Categories', :admin_categories_path

  def index
    @categories = Category.all
  end

  def new
    add_breadcrumb 'New'

    @category = Category.new
  end

  def edit
    add_breadcrumb 'Edit'
  end

  def create
    @category = Category.new(category_params)

    if @category.valid?
      @category.save!
      flash[:success] = "Added category: #{@category.name}"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def update
    if @category.update_attributes(category_params)
      flash[:success] = "Category updated successfully!"
      redirect_to admin_categories_path(@category)
    else
      render :edit
    end
  end

  private

  def find_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
