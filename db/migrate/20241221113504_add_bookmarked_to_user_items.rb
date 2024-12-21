class AddBookmarkedToUserItems < ActiveRecord::Migration[7.2]
  def change
    add_column :user_items, :bookmarked, :boolean, default: false, null: false
  end
end
