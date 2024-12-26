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
#
# Indexes
#
#  index_feeds_on_rss_url  (rss_url) UNIQUE
#
FactoryBot.define do
  factory :feed do
    title { "title" }
    description { "description" }
    rss_url { "https://example.com/rss" }
    url { "https://example.com" }
  end
end
