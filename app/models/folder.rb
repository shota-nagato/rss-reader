class Folder < ApplicationRecord
  belongs_to :user

  has_many :feed_subscriptions, dependent: :destroy
  has_many :feeds, through: :feed_subscriptions

  store_accessor :options, :toggle

  validates :name, presence: true

  def subscribe?(feed)
    feeds.include?(feed)
  end

  def subscribe(feed, user)
    feed_subscriptions.create!(feed:, user:)
  end

  def unsubscribe(feed, user)
    feed_subscriptions.find_by(feed:, user:).destroy!
  end
end
