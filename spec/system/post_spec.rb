require 'rails_helper'
RSpec.describe '危険情報投稿機能', type: :system do
  let(:area) { Area.find_by(name: "徳丸") }
  let(:second_area) { Area.find_by(name: "中台") }
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
    context '危険情報を新規投稿した場合' do
      it '作成した投稿が表示される' do
        visit new_post_path
        sleep(5)
        fill_in 'post_title', with: '道路が凍っていて危ないです'
        fill_in 'post_content', with: '昨晩の雨の後、急激な気温低下により坂道に氷が張ってます！転ばないように注意して下さい'
        find("#post_type").find("option[value='交通事故系']").select_option
        find("#post_name").find("option[value='西台']").select_option
        click_on '登録する'
        sleep(1)
        expect(page).to have_content '氷'
        expect(page).to have_content '凍っていて'
        expect(page).to have_content '交通事故'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        FactoryBot.create(:post, user: user, area: area)
        FactoryBot.create(:second_post, user: admin_user, area: second_area)
        visit posts_path
        expect(page).to have_content '小学生の女の子'
        expect(page).to have_content '黒い蛇'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意の投稿詳細画面に遷移した場合' do
       it '該当投稿の内容が表示される' do
        FactoryBot.create(:post, user: user, area: area)
        FactoryBot.create(:second_post, user: admin_user, area: second_area)
        visit post_path(Post.last)
        expect(page).to have_content 'へび'
        expect(page).to have_content '公衆トイレ'
        expect(page).to have_content '中台'
       end
     end
  end 
end
