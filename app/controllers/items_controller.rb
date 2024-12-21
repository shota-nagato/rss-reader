class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_folder
  before_action :set_feed
  before_action :set_items

  def search
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

  def change_view
    session[:type] = params[:type]

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(:items, partial: "items/item", collection: @items, as: :item, locals: {type: params[:type]})
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

  def set_items
    items = if @folder.present?
      Item.user_folder_items(@folder, current_user)
    elsif @feed.present?
      Item.user_feed_items(@feed, current_user)
    else
      current_user.items
    end

    items = items.eager_load(:user_items).where(user_items: {user: current_user, liked: true}) if params[:filter].present? && params[:filter][:liked].present?

    @items = if params[:query].present?
      items.by_keyword(params[:query]).order(published_at: :desc)
    else
      items.order(published_at: :desc)
    end
  end
end
