class FeedsController < ApplicationController
  before_action :authenticate_user!

  def index
    @feeds = current_user.feeds.distinct.order(created_at: :desc)
  end

  def new
  end

  def show
    @feed = Feed.find(params[:id])

    response = Faraday.get(@feed.rss_url)
    rss = Feedjira.parse(response.body)
    @entries = rss.entries
  end

  def search
    if valid_url?(params[:query])
      feed = fetch_and_save_feed(params[:query])
      feeds = feed.present? ? [feed] : []
    else
      feeds = Feed.search(params[:query])
    end

    respond_to do |format|
      format.turbo_stream do
        if params[:query].blank?
          render turbo_stream: turbo_stream.update(:search_result)
        else
          render turbo_stream: turbo_stream.update(:search_result, partial: "feeds/search_result", locals: {feeds: feeds})
        end
      end
    end
  end

  private

  def valid_url?(query)
    URI::DEFAULT_PARSER.make_regexp.match(query)
  end

  def fetch_and_save_feed(url)
    response = Faraday.get(url)
    return unless response.is_a?(Faraday::Response)

    parsed_data = Feedjira.parse(response.body)

    feed = Feed.find_or_initialize_by(rss_url: params[:query])
    if feed.new_record?
      feed.url = parsed_data.url
      feed.title = parsed_data.title
      feed.description = parsed_data.description
      feed.save!
    end
    feed
  rescue Faraday::ConnectionFailed
  rescue Feedjira::NoParserAvailable
  end
end
