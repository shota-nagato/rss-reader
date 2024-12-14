class CreateUserItems < ActiveRecord::Migration[7.2]
  def change
    create_table :user_items do |t|
      t.references :user, foreign_key: true, null: false
      t.references :item, foreign_key: true, null: false
      t.boolean :liked, null: false, default: false
      t.boolean :archived, null: false, default: false

      t.timestamps
    end
  end
end
