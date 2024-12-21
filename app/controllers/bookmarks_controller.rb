class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def index
    @items = current_user.items.eager_load(:user_items).where(user_items: {user: current_user, bookmarked: true}).order(published_at: :desc)
  end
end
