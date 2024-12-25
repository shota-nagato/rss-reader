class Admin::CategoriesController < Admin::ApplicationController
  before_action :set_category, only: %i[show edit update destroy]

  def index
    @categories = Category.order(created_at: :desc)
  end

  def show
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_path, notice: 'カテゴリを作成しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: 'カテゴリを更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
