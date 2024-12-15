class Folders::TogglesController < ApplicationController
  before_action :authenticate_user!

  def update
    @folder = current_user.folders.find(params[:folder_id])
    @folder.update(toggle: !@folder.toggle)
  end
end
