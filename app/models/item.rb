class Item < ApplicationRecord
  belongs_to :feed

  has_many :user_items, dependent: :destroy
  has_many :users, through: :user_items

  validates :title, :url, :published_at, presence: true
  validates :url, uniqueness: true

  scope :user_feed_items, ->(feed, user) { eager_load(:user_items, :feed).where(feed: feed, user_items: {user_id: user.id}) }
  scope :user_folder_items, ->(folder, user) { eager_load(:user_items, :feed).where(feed: folder.feeds, user_items: {user_id: user.id}) }
  scope :by_keyword, ->(keyword) { where(arel_table[:title].matches("%#{sanitize_sql_like(keyword)}%")) }

  def user_item(user)
    user_items.find { |user_item| user_item.user_id == user.id }
  end
end
