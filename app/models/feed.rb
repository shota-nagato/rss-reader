class Feed < ApplicationRecord
  validates :title, :rss_url, :url, presence: true
  validates :rss_url, uniqueness: true

  has_many :feed_subscriptions, dependent: :destroy
  has_many :holders, through: :feed_subscriptions
  has_many :items, dependent: :destroy

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
