class FoldersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_folder, only: %i[show destroy]

  def index
  end

  def show
  end

  def new
    @folder = Folder.new
  end

  def create
    @folder = current_user.folders.new(folder_params)

    respond_to do |format|
      if @folder.save
        format.turbo_stream {
          flash[:notice] = "フォルダーを作成しました"
          render turbo_stream: turbo_stream.action(:redirect, folder_path(@folder))
        }
      else
        format.html { render :new, status: :unprocessable_entity }
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
