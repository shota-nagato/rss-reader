class Admin::CategoriesController < Admin::ApplicationController
  def index
    @categories = Category.order(created_at: :desc)
  end

  def show
    @category = Category.find(params[:id])
  end
end
