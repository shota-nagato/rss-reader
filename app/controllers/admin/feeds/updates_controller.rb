class Admin::Feeds::UpdatesController < Admin::ApplicationController
  def update
    feed = Feed.find(params[:feed_id])

    SaveItemsJob.perform_later(feed)
    redirect_to admin_feeds_path, notice: "フィードを更新しました"
  end
end
