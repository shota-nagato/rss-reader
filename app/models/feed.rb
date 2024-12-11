class Feed < ApplicationRecord
  validates :title, :rss_url, :url, presence: true
  validates :rss_url, :url, uniqueness: true

  def self.search(query)
    return [] if query.blank?

    where(arel_table[:title].matches("%#{sanitize_sql_like(query)}%"))
  end
end
