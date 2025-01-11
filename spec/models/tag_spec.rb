# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_tags_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe Tag, type: :model do
  describe "factory" do
    subject { create(:tag) }

    it "レコードを新規作成できる" do
      expect { subject }.to change { Tag.count }.by(1)
    end
  end
end
