# == Schema Information
#
# Table name: items
#
#  id           :bigint           not null, primary key
#  image_url    :string
#  published_at :datetime         not null
#  summary      :text
#  title        :string           not null
#  url          :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  feed_id      :bigint           not null
#
# Indexes
#
#  index_items_on_feed_id  (feed_id)
#
# Foreign Keys
#
#  fk_rails_...  (feed_id => feeds.id)
#
require "rails_helper"

RSpec.describe Item, type: :model do
  describe "factory" do
    subject { create(:item) }

    it "レコードを新規作成できる" do
      expect { subject }.to change { Item.count }.by(1)
    end
  end
end
