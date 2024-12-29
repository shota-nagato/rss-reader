require "rails_helper"

RSpec.describe "Folders::Feeds", type: :system do
  let(:user) { create(:user) }
  let(:folder) { create(:folder, user: user) }
  let(:feed) { create(:feed) }

  before do
    create(:feed_subscription, folder:, feed:)
  end

  context "ログインしていない場合" do
    it "アクセスできない" do
      visit folder_feed_path(folder, feed)

      expect(page).to have_content "ログインもしくはアカウント登録してください。"
    end
  end

  context "ログインしている場合" do
    before do
      sign_in user
    end

    describe "一覧表示" do
      let(:item1) { create(:item, title: "記事1", feed:) }
      let(:item2) { create(:item, title: "記事2", feed:) }

      before do
        create(:user_item, item: item1, user:)
        create(:user_item, item: item2, user:)
      end

      it "フィードの記事が表示される" do
        visit folder_feed_path(folder, feed)

        expect(page).to have_content "記事1"
        expect(page).to have_content "記事2"
      end
    end

    describe "記事の更新" do
      before do
        create(:item, title: "記事1", feed:)
      end

      it "更新ボタンを押して新規記事を表示できる" do
        # 記事がない場合は更新処理が実行される
        expect do
          visit folder_feed_path(folder, feed)

          expect(page).to have_content "記事1"
        end.to change(UserItem, :count).by(1)

        # フィードの記事を更新
        create(:item, title: "記事2", feed:)

        # 購読中のフィードでは更新分は表示されない
        expect(page).not_to have_content "記事2"

        # 更新ボタンをクリック
        find("#feed-update-button").click

        expect(page).to have_content "記事2"
      end
    end

    describe "購読の解除" do
      let(:item) { create(:item, feed:) }

      before do
        create(:user_item, item:)
      end

      it "フィードの購読を解除できる" do
        visit folder_feed_path(folder, feed)

        expect do
          # ドロップダウンを開く
          find("#folder-feed-dropdown").click
          click_link "登録解除"

          expect(page).to have_content "購読を解除しました"
          expect(page).to have_current_path folder_path(folder)
        end.to change(FeedSubscription, :count).by(-1).and change(UserItem, :count).by(-1)
      end
    end

    describe "お気に入り" do
      let(:item) { create(:item, feed:) }

      before do
        create(:user_item, item:)
      end

      it "記事をお気に入り登録できる" do
        visit folder_feed_path(folder, feed)
        find("#like_user_item_#{UserItem.last.id}").click

        # お気に入りページに遷移して表示されるか検証
        visit folder_feed_path(folder, feed, liked: true)

        expect(page).not_to have_content "記事はありません"
      end
    end

    describe "ブックマーク" do
      let(:item) { create(:item, feed:) }

      before do
        create(:user_item, item:)
      end

      it "記事をブックマーク登録できる" do
        visit folder_feed_path(folder, feed)
        find("#bookmark_user_item_#{UserItem.last.id}").click

        # お気に入りページに遷移して表示されるか検証
        visit bookmarks_path

        expect(page).not_to have_content "記事はありません"
      end
    end
  end
end
