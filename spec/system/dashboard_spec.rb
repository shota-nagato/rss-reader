require "rails_helper"

RSpec.describe "Dashboard", type: :system do
  context "ログインしていない場合" do
    it "アクセスできない" do
      visit user_root_path

      expect(page).not_to have_content "本日の記事"
    end
  end

  context "ログインしている場合" do
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    it "アクセスできる" do
      visit user_root_path

      expect(page).to have_content "本日の記事"
    end
  end
end
