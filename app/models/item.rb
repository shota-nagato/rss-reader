class Item < ApplicationRecord
  belongs_to :feed

  has_many :user_items, dependent: :destroy
  has_many :users, through: :user_items

  validates :title, :url, :published_at, presence: true
  validates :url, uniqueness: true

  scope :user_feed_items, ->(feed, user) { eager_load(:user_items).where(feed: feed, user_items: {user_id: user.id}) }
  scope :user_folder_items, ->(folder, user) { eager_load(:user_items).where(feed: folder.feeds, user_items: {user_id: user.id}) }
end
