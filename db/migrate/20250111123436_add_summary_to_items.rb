class AddSummaryToItems < ActiveRecord::Migration[7.2]
  def change
    add_column :items, :summary, :text
  end
end
