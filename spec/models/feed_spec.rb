# == Schema Information
#
# Table name: feeds
#
#  id          :bigint           not null, primary key
#  description :text
#  rss_url     :string           not null
#  title       :string           not null
#  url         :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint
#
# Indexes
#
#  index_feeds_on_category_id  (category_id)
#  index_feeds_on_rss_url      (rss_url) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#
require "rails_helper"

RSpec.describe Feed, type: :model do
  describe "factory" do
    subject { create(:feed) }

    it "レコードを新規作成できる" do
      expect { subject }.to change { Feed.count }.by(1)
    end
  end
end
