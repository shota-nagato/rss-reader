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
class Feed < ApplicationRecord
  validates :title, :rss_url, :url, presence: true
  validates :rss_url, uniqueness: true

  has_many :feed_subscriptions, dependent: :destroy
  has_many :holders, through: :feed_subscriptions
  has_many :items, dependent: :destroy

  belongs_to :category, optional: true

  def self.search(query)
    return [] if query.blank?

    where(arel_table[:title].matches("%#{sanitize_sql_like(query)}%"))
  end

  def update_user_items(user)
    items.each do |item|
      UserItem.find_or_create_by(item: item, user: user)
    end
  end
end
