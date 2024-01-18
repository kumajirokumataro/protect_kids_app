require 'rails_helper'
RSpec.describe '子供の安全に関する自由投稿機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:admin_user) { FactoryBot.create(:admin_user) }
  describe '新規作成機能' do
    before do
      visit new_session_path
      sleep(1)
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      all('.login')[0].find_button("ログイン").click
      sleep(1)
    end
    context '自由投稿を新規投稿した場合' do
      it '作成した投稿が表示される' do
        visit new_free_post_path
        sleep(1)
        fill_in 'free_post_title', with: '息子が熱いコーヒーを浴びてしまい、大火傷を追ってしまいました'
        fill_in 'free_post_content', with: 'テーブルの上に入れたての熱いコーヒーを置いていると、たまたまテーブル近くにいた息子がそのコーヒーに触ってこぼしてしまい、それが手にかかってしまい、
        手に大火傷を負ってしまいました。本当にかわいそうなことをしてしまいました。注意しましょう。'
        find("#free_post_kind").find("option[value='自宅にて']").select_option
        find("#free_post_target_child_age").find("option[value='0歳']").select_option
        click_on '登録する'
        sleep(1)
        expect(page).to have_content '大火傷'
        expect(page).to have_content '息子'
        expect(page).to have_content 'テーブル'
      end
    end
  end

  describe '一覧表示機能' do
    context '自由投稿一覧画面に遷移した場合' do
      it '投稿済みの一覧が表示される' do
        FactoryBot.create(:free_post, user: user)
        FactoryBot.create(:second_free_post, user: admin_user)
        visit free_posts_path
        expect(page).to have_content '大火傷'
        expect(page).to have_content 'トマトやブドウ'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意の投稿詳細画面に遷移した場合' do
       it '該当投稿の内容が表示される' do
        FactoryBot.create(:free_post, user: user)
        FactoryBot.create(:second_free_post, user: admin_user)
        visit free_post_path(FreePost.last)
        expect(page).to have_content 'トマトやブドウ'
        expect(page).to have_content 'おにぎり'
        expect(page).to have_content '食事中'
       end
     end
  end 
end

