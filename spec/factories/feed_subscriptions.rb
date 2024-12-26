# == Schema Information
#
# Table name: feed_subscriptions
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  feed_id    :bigint           not null
#  folder_id  :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_feed_subscriptions_on_feed_id    (feed_id)
#  index_feed_subscriptions_on_folder_id  (folder_id)
#  index_feed_subscriptions_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (feed_id => feeds.id)
#  fk_rails_...  (folder_id => folders.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :feed_subscription do
    association :feed
    association :folder
    user { folder.user }
  end
end
