class Folders::FeedsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_folder

  def show
    @feed = @folder.feeds.find(params[:id])
    @items = Item.user_feed_items(@feed, current_user).order(published_at: :desc)

    # 購読直後は記事が0なので初めてfeed詳細遷移するタイミングで保存
    @feed.update_user_items(current_user) if @items.count.zero?
  end

  private

  def set_folder
    @folder = current_user.folders.find(params[:folder_id])
  end
end
