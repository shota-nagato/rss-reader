# == Schema Information
#
# Table name: user_items
#
#  id         :bigint           not null, primary key
#  archived   :boolean          default(FALSE), not null
#  bookmarked :boolean          default(FALSE), not null
#  liked      :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_user_items_on_item_id  (item_id)
#  index_user_items_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (item_id => items.id)
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe UserItem, type: :model do
  describe "factory" do
    subject { create(:user_item) }

    it "レコードを新規作成できる" do
      expect { subject }.to change { UserItem.count }.by(1)
    end
  end
end
