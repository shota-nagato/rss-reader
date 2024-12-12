class CreateFeedSubscriptions < ActiveRecord::Migration[7.2]
  def change
    create_table :feed_subscriptions do |t|
      t.references :user, foreign_key: true, null: false
      t.references :feed, foreign_key: true, null: false
      t.references :folder, foreign_key: true, null: false
      t.timestamps
    end
  end
end
