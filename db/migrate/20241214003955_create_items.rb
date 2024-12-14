class CreateItems < ActiveRecord::Migration[7.2]
  def change
    create_table :items do |t|
      t.references :feed, foreign_key: true, null: false
      t.string :title, null: false
      t.string :url, null: false
      t.string :image_url
      t.datetime :published_at, null: false

      t.timestamps
    end
  end
end
