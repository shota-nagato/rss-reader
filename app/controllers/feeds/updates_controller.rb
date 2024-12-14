class Feeds::UpdatesController < ApplicationController
  before_action :authenticate_user!

  def update
    feed = Feed.find(params[:feed_id])
    return unless current_user.subscribe?(feed)

    sleep 1

    feed.update_user_items(current_user)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(:items, partial: "folders/feeds/item", collection: feed.items, as: :item)
      end
    end
  end
end
