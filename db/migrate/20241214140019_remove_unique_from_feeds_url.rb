class RemoveUniqueFromFeedsUrl < ActiveRecord::Migration[7.2]
  def change
    remove_index :feeds, column: :url
    add_index :feeds, :rss_url, unique: true
  end
end
