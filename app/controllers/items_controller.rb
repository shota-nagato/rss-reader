class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_folder
  before_action :set_feed

  def search
    @items = if @folder.present?
      Item.user_folder_items(@folder, current_user).by_keyword(params[:query])
    elsif @feed.present?
      Item.user_feed_items(@feed, current_user).by_keyword(params[:query])
    else
      @items = current_user.items.by_keyword(params[:query])
    end

    respond_to do |format|
      format.turbo_stream do
        if @items.count.zero?
          render turbo_stream: turbo_stream.update(:items, partial: "shared/not_found")
        else
          render turbo_stream: turbo_stream.update(:items, partial: "items/item", collection: @items, as: :item, locals: {type: params[:type]})
        end
      end
    end
  end

  private

  def set_folder
    @folder = current_user.folders.find(params[:folder_id]) if params[:folder_id].present?
  end

  def set_feed
    @feed = current_user.feeds.find(params[:feed_id]) if params[:feed_id].present?
  end
end
