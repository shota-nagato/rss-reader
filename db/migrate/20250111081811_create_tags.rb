class CreateTags < ActiveRecord::Migration[7.2]
  def change
    create_table :tags do |t|
      t.string :name, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
