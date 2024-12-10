class AddDescriptionToFeeds < ActiveRecord::Migration[7.2]
  def change
    add_column :feeds, :description, :text
  end
end
