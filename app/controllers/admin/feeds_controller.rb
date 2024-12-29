class Admin::FeedsController < Admin::ApplicationController
  before_action :set_feed, only: %i[show edit update]

  def index
    @feeds = Feed.order(created_at: :desc)
  end

  def show
  end

  def edit
  end

  def update
    if @feed.update(category_params)
      redirect_to admin_feed_path(@feed), notice: "フィードを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_feed
    @feed = Feed.find(params[:id])
  end

  def category_params
    params.require(:feed).permit(:title, :rss_url, :url, :description, :category_id)
  end
end
