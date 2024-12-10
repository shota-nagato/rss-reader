class FeedsController < ApplicationController
  before_action :authenticate_user!

  def new
    @feeds = Feed.new
  end

  def search
    response = fetch_feed(params[:url])

    respond_to do |format|
      format.turbo_stream do
        if response.is_a?(Faraday::Response)
          feed = Feedjira.parse(response.body)

          @feed = Feed.find_or_initialize_by(url: params[:url])
          if @feed.new_record?
            @feed.title = feed.title
            @feed.description = feed.description
            @feed.save!
          end

          render turbo_stream: turbo_stream.replace(:feed, partial: "feeds/feed", locals: {feed: @feed})
        else
          render turbo_stream: turbo_stream.replace(:feed, partial: "feeds/not_found")
        end
      end
    end
  end

  private

  def fetch_feed(url)
    Faraday.get(url)
  rescue Faraday::ConnectionFailed
    nil
  end
end
