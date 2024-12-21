class FoldersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_folder, only: %i[show edit update destroy]

  def index
  end

  def show
    @items = Item.user_folder_items(@folder, current_user).order(published_at: :desc)
    @items = @items.eager_load(:user_items).where(user_items: {user: current_user, liked: true}) if params[:liked].present?
  end

  def new
    @folder = Folder.new
  end

  def edit
  end

  def create
    @folder = current_user.folders.new(folder_params)

    respond_to do |format|
      if @folder.save
        format.turbo_stream {
          flash[:notice] = "フォルダを作成しました"
          render turbo_stream: turbo_stream.action(:redirect, folder_path(@folder))
        }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @folder.update(folder_params)
        format.turbo_stream {
          flash[:notice] = "フォルダを編集しました"
          render turbo_stream: turbo_stream.action(:redirect, folder_path(@folder))
        }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @folder.destroy!

    redirect_to feeds_path, notice: "フォルダを削除しました。"
  end

  private

  def folder_params
    params.require(:folder).permit(:name)
  end

  def set_folder
    @folder = current_user.folders.find(params[:id])
  end
end
