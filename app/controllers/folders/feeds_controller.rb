class Folders::FeedsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_folder

  def show
    @feed = @folder.feeds.find(params[:id])
    SaveItemsJob.perform_later(@feed)
  end

  private

  def set_folder
    @folder = current_user.folders.find(params[:folder_id])
  end
end
