class Feeds::UpdatesController < ApplicationController
  before_action :authenticate_user!

  def update
    feed = Feed.find(params[:feed_id])
    return unless current_user.subscribe?(feed)

    sleep 1

    feed.update_user_items(current_user)

    items = feed.items.order(published_at: :desc)
    items = items.eager_load(:user_items).where(user_items: {user: current_user, liked: true}) if params[:liked].present?

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(:items, partial: "items/item", collection: items, as: :item, locals: {type: params[:type]})
      end
    end
  end
end
