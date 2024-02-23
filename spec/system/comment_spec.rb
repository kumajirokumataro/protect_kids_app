require 'rails_helper'
RSpec.describe 'Ajaxによるコメント機能', type: :system do
  let(:area) { Area.find_by(name: "徳丸") }
  let!(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, user: user, area: area) }
  
  describe 'コメント登録機能' do
    before do
      visit new_session_path
      sleep(1)
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      all('.login')[0].find_button("ログイン").click
      sleep(1)
    end
    context 'ログインユーザーが危険情報詳細画面にアクセスした場合' do
      it 'コメント投稿欄がある。' do
        visit post_path(post)
        expect(page).to have_content '投稿者へメッセージコメント'
      end      
    end        
    context 'ログインユーザーが危険情報詳細画面にアクセスした場合' do
      it 'コメント入力画面があり、入力すると正常にコメント入力が完了する' do
        visit post_path(post)
        sleep(1)
        fill_in 'comment_content', with: '助かりました！'
        click_on '登録する'
        sleep(1)
        expect(page).to have_content '助かりました！'
      end
    end
    context '会員登録していないユーザーが危険情報詳細画面にアクセスした場合' do
      it 'コメント入力画面がない' do
        click_on 'ログアウト'
        sleep(1)
        click_on '危険投稿一覧'
        sleep(1)
        click_on '投稿詳細'
        sleep(1)
        expect(page).not_to have_content '投稿者へメッセージコメント'
      end
    end
  end
end