require "rails_helper"

RSpec.describe "Folders", type: :system do
  context "ログインしていない場合" do
    it "アクセスできない" do
      visit new_folder_path

      expect(page).to have_content "ログインもしくはアカウント登録してください。"
    end
  end

  context "ログインしている場合" do
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    describe "新規作成" do
      it "フォルダを作成できる" do
        visit user_root_path
        click_link "フォルダを追加"
        fill_in "folder_name", with: "プログラミング"

        expect do
          click_button "保存"

          expect(page).to have_content "フォルダを作成しました"
          expect(page).to have_content "プログラミング"
        end.to change(user.folders, :count).by(1)
      end
    end

    describe "詳細表示" do
      let(:folder) { create(:folder, name: "プログラミング", user: user) }

      context "登録しているフィードがない場合" do
        it "フィードがない文言と登録ボタンが表示される" do
          visit folder_path(folder)

          expect(page).to have_content "プログラミング"
          expect(page).to have_content "登録しているフィードはありません"
          expect(page).to have_link "登録する", href: new_feed_path
        end
      end

      context "作成したユーザーでない場合" do
        let(:other_user) { create(:user) }
        let(:other_folder) { create(:folder, user: other_user) }

        it "アクセスできない" do
          visit folder_path(other_folder)
          expect(page.status_code).to eq 404
        end
      end
    end

    describe "編集" do
      let(:folder) { create(:folder, name: "編集前のフォルダ", user: user) }

      it "フォルダを編集できる" do
        visit folder_path(folder)
        # ドロップダウンを開く
        find("#folder-dropdown").click
        click_link "編集", exact: true
        sleep 2
        expect(page).to have_content "フォルダを編集"
        fill_in "folder_name", with: "編集後のフォルダ"
        click_button "保存"

        expect(page).to have_content "フォルダを編集しました"
        expect(page).to have_content "編集後のフォルダ"
      end
    end

    describe "削除" do
      let(:folder) { create(:folder, user: user) }

      it "フォルダを削除できる" do
        visit folder_path(folder)
        # ドロップダウンを開く
        find("#folder-dropdown").click

        expect do
          accept_confirm("本当に削除しますか?") do
            click_link "削除"
          end

          expect(page).to have_content "フォルダを削除しました"
          expect(page).to have_current_path feeds_path
        end.to change(Folder, :count).by(-1)
      end
    end
  end
end
