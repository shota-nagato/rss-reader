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
FactoryBot.define do
  factory :feed do
    title { "title" }
    description { "description" }
    rss_url { |n| "https://example.com#{n}/rss" }
    url { |n| "https://example#{n}.com" }
  end
end
