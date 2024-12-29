require "rails_helper"

RSpec.describe "Admin Feeds", type: :system do
  context "ログインしていない場合" do
    it "アクセスできない" do
      visit admin_feeds_path

      expect(page).not_to have_content "フィード"
    end
  end

  context "一般ユーザーとしてログインしている場合" do
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    it "アクセスできない" do
      visit admin_feeds_path

      expect(page).not_to have_content "フィード"
    end
  end

  context "管理者としてログインしている場合" do
    let(:admin) { create(:user, :admin) }

    before do
      sign_in admin
    end

    describe "一覧表示" do
      before do
        create(:feed, title: "フィード1")
        create(:feed, title: "フィード2")
      end

      it "フィード一覧が表示される" do
        visit admin_feeds_path

        expect(page).to have_content "フィード1"
        expect(page).to have_content "フィード2"
      end
    end

    describe "詳細表示" do
      let(:feed) { create(:feed, title: "フィード1") }

      it "詳細情報が表示され、編集ボタンが存在する" do
        visit admin_feed_path(feed)

        expect(page).to have_content "フィード1"
        expect(page).to have_link "編集", href: edit_admin_feed_path(feed)
      end
    end

    describe "編集" do
      let(:feed) { create(:feed, title: "編集前のフィード") }

      it "フィードを編集できる" do
        visit edit_admin_feed_path(feed)
        fill_in "タイトル", with: "編集後のフィード"

        expect do
          click_button "編集"

          expect(page).to have_content "フィードを更新しました"
          expect(page).to have_current_path admin_feed_path(feed)
          expect(page).to have_content "編集後のフィード"
        end.to change(Feed, :count).by(0)
      end
    end
  end
end
