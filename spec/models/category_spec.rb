# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper"

RSpec.describe Category, type: :model do
  describe "factory" do
    subject { create(:category) }

    it "レコードを新規作成できる" do
      expect { subject }.to change { Category.count }.by(1)
    end
  end
end
