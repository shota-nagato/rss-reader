class Feed < ApplicationRecord
  validates :title, :rss_url, :url, presence: true
  validates :rss_url, :url, uniqueness: true

  has_many :feed_subscriptions, dependent: :destroy
  has_many :holders, through: :feed_subscriptions

  def self.search(query)
    return [] if query.blank?

    where(arel_table[:title].matches("%#{sanitize_sql_like(query)}%"))
  end
end
