require "rails_helper"

RSpec.describe "Admin Categories", type: :system do
  context "ログインしていない場合" do
    it "アクセスできない" do
      visit admin_categories_path

      expect(page).not_to have_content "カテゴリー"
    end
  end

  context "一般ユーザーとしてログインしている場合" do
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    it "アクセスできない" do
      visit admin_categories_path

      expect(page).not_to have_content "ダッシュボード"
    end
  end

  context "管理者としてログインしている場合" do
    let(:admin) { create(:user, :admin) }

    before do
      sign_in admin
    end

    describe "一覧表示" do
      before do
        create(:category, name: "ビジネス")
        create(:category, name: "プログラミング")
      end

      it "カテゴリ一覧が表示される" do
        visit admin_categories_path

        expect(page).to have_content "カテゴリー"
        expect(page).to have_content "ビジネス"
        expect(page).to have_content "プログラミング"
      end
    end

    describe "詳細表示" do
      let(:category) { create(:category, name: "ビジネス") }

      it "詳細情報が表示され、編集ボタンが存在する" do
        visit admin_category_path(category)

        expect(page).to have_content "ビジネス"
        expect(page).to have_link "編集", href: edit_admin_category_path(category)
      end

      it "削除ボタンが存在し、削除できる" do
        visit admin_category_path(category)

        expect do
          accept_confirm("本当に削除しますか?") do
            click_link "削除"
          end

          expect(page).to have_content "カテゴリを削除しました"
          expect(page).to have_current_path admin_categories_path
          expect(page).not_to have_content "ビジネス"
        end.to change(Category, :count).by(-1)
      end
    end

    describe "新規登録" do
      it "カテゴリを登録できる" do
        visit new_admin_category_path
        fill_in "カテゴリ名", with: "ビジネス"

        expect do
          click_button "作成"

          expect(page).to have_content "カテゴリを作成しました"
          expect(page).to have_current_path admin_categories_path
          expect(page).to have_content "ビジネス"
        end.to change(Category, :count).by(1)
      end
    end

    describe "編集" do
      let(:category) { create(:category, name: "編集前のカテゴリ") }

      it "カテゴリを編集できる" do
        visit edit_admin_category_path(category)
        fill_in "カテゴリ名", with: "編集後のカテゴリ"

        expect do
          click_button "編集"

          expect(page).to have_content "カテゴリを更新しました"
          expect(page).to have_current_path admin_category_path(category)
          expect(page).to have_content "編集後のカテゴリ"
        end.to change(Category, :count).by(0)
      end
    end
  end
end
