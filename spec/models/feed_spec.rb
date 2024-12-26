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
require "rails_helper"

RSpec.describe Feed, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
