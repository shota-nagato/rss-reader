class CreateItemTags < ActiveRecord::Migration[7.2]
  def change
    create_table :item_tags do |t|
      t.references  :item, foreign_key: true, null: false
      t.references :tag, foreign_key: true, null: false

      t.timestamps
    end
  end
end
