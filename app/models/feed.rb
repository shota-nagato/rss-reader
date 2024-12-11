class Feed < ApplicationRecord
  validates :title, :url, presence: true
  validates :url, uniqueness: true

  def self.search(query)
    return [] if query.blank?

    where(arel_table[:title].matches("%#{sanitize_sql_like(query)}%"))
  end
end
