class AddRssLinkToFeeds < ActiveRecord::Migration[7.2]
  def change
    add_column :feeds, :rss_url, :string, null: false
  end
end
