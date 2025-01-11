# == Schema Information
#
# Table name: item_tags
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :bigint           not null
#  tag_id     :bigint           not null
#
# Indexes
#
#  index_item_tags_on_item_id  (item_id)
#  index_item_tags_on_tag_id   (tag_id)
#
# Foreign Keys
#
#  fk_rails_...  (item_id => items.id)
#  fk_rails_...  (tag_id => tags.id)
#
require "rails_helper"

RSpec.describe ItemTag, type: :model do
  describe "factory" do
    subject { create(:item_tag) }

    it "レコードを新規作成できる" do
      expect { subject }.to change { ItemTag.count }.by(1)
    end
  end
end
