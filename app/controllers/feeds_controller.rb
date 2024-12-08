class FeedsController < ApplicationController
  before_action :authenticate_user!

  def new
    @feeds = Feed.new
  end
end
