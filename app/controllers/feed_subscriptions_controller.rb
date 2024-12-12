class FeedSubscriptionsController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :authenticate_user!
  before_action :set_feed

  def new
  end

  def create
    folder = current_user.folders.find(params[:folder_id])
    @feed_subscription = folder.feed_subscriptions.new(feed: @feed, user: current_user)

    if folder.subscribe?(@feed)
      folder.unsubscribe(@feed, current_user)
    else
      folder.subscribe(@feed, current_user)
    end

    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: [
          turbo_stream.replace(
            dom_id(@feed, folder.id),
            partial: "feed_subscriptions/add_button", locals: {feed: @feed, folder: folder}
          ),
          if folder.subscribe?(@feed)
            turbo_stream.append(
              dom_id(folder),
              partial: "feeds/sidebar/feed", locals: {feed: @feed, folder: folder}
            )
          else
            turbo_stream.remove(dom_id(folder, @feed.id))
          end
        ]
      }
    end
  end

  private

  def set_feed
    @feed = Feed.find(params[:feed_id])
  end
end
