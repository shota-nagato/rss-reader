class AddCategoryIdToFeeds < ActiveRecord::Migration[7.2]
  def change
    add_reference :feeds, :category, foreign_key: true
  end
end
