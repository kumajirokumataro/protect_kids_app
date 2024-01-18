require 'rails_helper'
RSpec.describe 'ユーザー機能', type: :system do
  describe 'ユーザー登録機能' do
    context 'ユーザー新規登録した場合' do
      it '新規登録が正常に完了する' do
        visit new_user_path
        sleep(1)
        fill_in 'user_name', with: 'kumiko'
        fill_in 'user_email', with: 'kumiko@gmail.com'
        fill_in 'user_password', with: 'ninniku'
        fill_in 'user_password_confirmation', with: 'ninniku'
        fill_in 'user_nickname', with: 'kumi'
        area_tokiwadai = Area.find_by(name: "常盤台")
        check "user_area_ids_#{area_tokiwadai.id}"
        find("#user_gender").find("option[value='女性']").select_option
        find("#user_age").find("option[value='40代']").select_option
        click_on '登録する'
        sleep(1)
        expect(page).to have_content 'ゲストログイン'
        expect(page).to have_content 'ゲスト管理者用ログイン'
      end
    end
    context 'ログインせずに危険情報一覧にとんだ場合' do
      it '新規投稿のリンクが表示されない' do
        visit posts_path
        sleep(1)
        expect(page).not_to have_content '新規投稿'
        expect(page).not_to have_content 'こちらをクリックして危険情報を投稿して下さい'
      end
    end
  end
  describe 'セッション機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:other_user) { FactoryBot.create(:admin_user) }
    before do
      visit new_session_path
      sleep(1)
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      all('.login')[0].find_button("ログイン").click
      sleep(1)
    end
    context 'ログインした場合' do
      it "正常にログインする" do
        expect(page).to have_content '新規投稿'
        expect(page).to have_content 'こちらをクリックして危険情報を投稿して下さい'
      end
    end
    context 'ログインした場合' do
      it "自分の詳細ページに飛び、編集更新することができる" do
        click_on 'マイページ'
        sleep(1)
        click_on '編集'
        sleep(1)
        expect(page).to have_content "確認用パスワード"
        expect(page).to have_content "自己紹介"         
        expect(page).to have_content "編集"         
      end
    end
    context '他人の編集画面に飛んだ場合' do
      it "他人の詳細ページは編集することができない" do
        visit edit_user_path(other_user.id)
        sleep(1)
        expect(page).to have_content '新規投稿'
        expect(page).to have_content 'こちらをクリックして危険情報を投稿して下さい'
      end
    end
    context 'ログアウトした場合' do
      it "正常にログアウトが完了する" do
        click_on 'ログアウト'
        sleep(1)
        expect(page).to have_content 'ゲストログイン'
        expect(page).to have_content 'ゲスト管理者用ログイン'
      end
    end
  end

  describe '管理機能' do
      let(:area) { Area.find_by(name: "徳丸") }
      let(:second_area) { Area.find_by(name: "中台") }
      let!(:user) { FactoryBot.create(:user) }
      let!(:admin_user) { FactoryBot.create(:admin_user) }
      let!(:post) { FactoryBot.create(:post, user: user, area: area) }
      let!(:comment) { FactoryBot.create(:comment, post: post) }
      before do
        visit new_session_path
        sleep(1)
        fill_in 'user_email', with: admin_user.email
        fill_in 'user_password', with: admin_user.password
        all('.login')[0].find_button("ログイン").click
        sleep(1)
      end
      context '管理ユーザーが管理画面にアクセスした場合' do
        it "管理画面にアクセスできること" do
          click_on '管理者用'
          sleep(1)
          expect(page).to have_content 'サイト管理'
          expect(page).to have_content 'Admin'
        end
      end
      
    context '管理ユーザーが危険情報詳細画面にアクセスした場合' do
      it "コメント欄に編集と削除のリンクがある。" do
        visit post_path(post)
        sleep(1)
        expect(page).to have_content '編集'
        expect(page).to have_content '削除'
      end
    end
        
    context '管理ユーザーが危険情報詳細画面にアクセスしコメントを編集した場合' do
      it "正常に更新できること" do
        visit post_path(post)
        sleep(1)
        click_on 'コメント編集'
        sleep(1)
        fill_in "comment_content_#{post.id}", with: '貴重な情報ありがとうございます！学校へも連絡します！'
        click_on '更新する'
        expect(page).to have_content "学校へも連絡します！"
      end
    end
    context '管理ユーザーが危険情報詳細画面にアクセスしコメントを削除した場合' do
      it "正常に削除できること" do
        visit post_path(post)
        sleep(1)
        click_on 'コメント削除'
        page.driver.browser.switch_to.alert.accept
        sleep(1)
        expect(page).not_to have_content '貴重な情報ありがとうございます！'
      end
    end
      
    context '一般ユーザーが管理画面にアクセスした場合' do
      it "管理画面にアクセスできないこと" do
        click_on 'ログアウト'
        sleep(1)
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: user.password
        all('.login')[0].find_button("ログイン").click
        sleep(1)
        visit rails_admin_path
        expect(page).not_to have_content 'サイト管理'
      end
    end
  end
end