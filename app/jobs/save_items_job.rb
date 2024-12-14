class SaveItemsJob < ApplicationJob
  queue_as :default

  def perform(saved_feed)
    response = Faraday.get(saved_feed.rss_url)
    return unless response.is_a?(Faraday::Response)

    fetched_feed = Feedjira.parse(response.body)

    fetched_feed.entries.each do |item|
      saved_feed.items.find_or_create_by(title: item.title, url: item.url, image_url: item.image, published_at: item.published)
    end
  end
end
