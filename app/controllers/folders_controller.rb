class FoldersController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    @folder = current_user.folders.find(params[:id])
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

  private

  def folder_params
    params.require(:folder).permit(:name)
  end
end
