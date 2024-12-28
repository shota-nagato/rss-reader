require "rails_helper"

RSpec.describe "Folders", type: :system do
  context "ログインしていない場合" do
    it "アクセスできない" do
      visit new_feed_path

      expect(page).to have_content "ログインもしくはアカウント登録してください。"
    end
  end

  context "ログインしている場合" do
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    describe "フィードの登録" do
      let(:url) { "https://example.com/feed" }
      let(:content) { File.read("spec/fixtures/files/rss_feed.xml") }

      before do
        create(:folder, name: "フォルダ1", user:)
        stub_request(:get, url).to_return(status: 200, body: content, headers: {"Content-Type" => "application/rss+xml"})
      end

      it "フィードを登録できる" do
        visit new_feed_path

        expect do
          fill_in "query", with: url

          expect(page).to have_content "サンプルフィード"
          expect(page).to have_content "これはサンプルフィードです"
        end.to change(Feed, :count).by(1)

        # 検索結果に表示されるフィードをクリック
        click_link "サンプルフィード"

        expect(page).to have_current_path(feed_path(Feed.last))

        click_link "登録"

        expect do
          click_link "追加", exact: true

          # 追加ボタンが削除ボタンに変わる
          expect(page).to have_content "削除"
        end.to change(FeedSubscription, :count).by(1)
      end
    end

    describe "フィード一覧" do
      context "フィードが登録されていない場合" do
        it "記事がない文言が表示される" do
          visit feeds_path

          expect(page).to have_content "記事はありません"
        end
      end

      context "フィードが登録されている場合" do
        let(:folder) { create(:folder, user:) }
        let(:feed) { create(:feed) }
        let(:item1) { create(:item, title: "記事1", feed:) }
        let(:item2) { create(:item, title: "記事2", feed:) }

        before do
          create(:feed_subscription, feed:, folder:, user:)
          create(:user_item, item: item1, user:)
          create(:user_item, item: item2, user:)
        end

        it "全ての記事が表示される" do
          visit feeds_path

          expect(page).to have_content "記事1"
          expect(page).to have_content "記事2"
        end
      end
    end
  end
end
