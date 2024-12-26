# == Schema Information
#
# Table name: user_items
#
#  id         :bigint           not null, primary key
#  archived   :boolean          default(FALSE), not null
#  bookmarked :boolean          default(FALSE), not null
#  liked      :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_user_items_on_item_id  (item_id)
#  index_user_items_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (item_id => items.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :user_item do
    association :user
    association :item
  end
end
