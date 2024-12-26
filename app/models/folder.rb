# == Schema Information
#
# Table name: folders
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  options    :json             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_folders_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
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
