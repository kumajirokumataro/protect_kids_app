require 'rails_helper'
RSpec.describe 'Ajaxによるコメント機能', type: :system do
  describe 'コメント登録機能' do
    context 'ログインユーザーが危険情報詳細画面にアクセスした場合' do
      it 'コメント欄に編集と削除のリンクがある。' do
        visit new_user_path
        sleep(1)
        fill_in 'user_name', with: 'kumiko'
        fill_in 'user_email', with: 'kumiko@gmail'
        fill_in 'user_password', with: 'ninniku'
        fill_in 'user_password_confirmation', with: 'ninniku'
        click_on 'Create my account'
        sleep(1)
        expect(page).to have_content 'kumikoのページ'
        expect(page).to have_content 'kumiko@gmail'
      end
    end
    context '会員登録していないユーザーが危険情報詳細画面にアクセスした場合' do
      it "コメント欄に編集と削除のリンクが無い。" do
        visit tasks_path
        sleep(1)
        expect(page).to have_content 'Log in'        
      end
    end
    context 'ログインユーザーが危険情報詳細画面にアクセスした場合' do
      it 'コメント入力画面があり、入力すると正常にコメント入力が完了する' do
        visit new_user_path
        sleep(1)
        fill_in 'user_name', with: 'kumiko'
        fill_in 'user_email', with: 'kumiko@gmail'
        fill_in 'user_password', with: 'ninniku'
        fill_in 'user_password_confirmation', with: 'ninniku'
        click_on 'Create my account'
        sleep(1)
        expect(page).to have_content 'kumikoのページ'
        expect(page).to have_content 'kumiko@gmail'
      end
    end
    context '会員登録していないユーザーが危険情報詳細画面にアクセスした場合' do
      it 'コメント入力画面がない' do
        visit new_user_path
        sleep(1)
        fill_in 'user_name', with: 'kumiko'
        fill_in 'user_email', with: 'kumiko@gmail'
        fill_in 'user_password', with: 'ninniku'
        fill_in 'user_password_confirmation', with: 'ninniku'
        click_on 'Create my account'
        sleep(1)
        expect(page).to have_content 'kumikoのページ'
        expect(page).to have_content 'kumiko@gmail'
      end
    end

  end
  
end