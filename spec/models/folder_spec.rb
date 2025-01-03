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
require "rails_helper"

RSpec.describe Folder, type: :model do
  describe "factory" do
    subject { create(:folder) }

    it "レコードを新規作成できる" do
      expect { subject }.to change { Folder.count }.by(1)
    end
  end
end
