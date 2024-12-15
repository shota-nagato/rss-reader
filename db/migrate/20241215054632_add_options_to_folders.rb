class AddOptionsToFolders < ActiveRecord::Migration[7.2]
  def change
    add_column :folders, :options, :json, null: false, default: {}
  end
end
