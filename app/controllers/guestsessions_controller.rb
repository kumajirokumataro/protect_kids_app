class GuestsessionsController < ApplicationController
  skip_before_action :login_required, only: [:new_guest, :new_admin_guest]
  
  def new_guest
    user = User.find_or_create_by(email: 'guest@gmail.com') do |user|
      user.name = 'ゲストユーザー'
      user.nickname = 'ゲスト'
      user.password = '111111'
    end
    session[:user_id] = user.id
    flash[:notice] = 'ゲストユーザーとしてログインしました'
    redirect_to posts_path
  end

  def new_admin_guest
    user = User.find_or_create_by(email: 'guestadmin@gmail.com') do |user|
      user.name = 'ゲスト管理者ユーザー'
      user.nickname = 'ゲスト管理者'
      user.password = '111111'
      user.admin = true
    end
    session[:user_id] = user.id
    flash[:notice] = 'ゲスト管理者ユーザーとしてログインしました'
    redirect_to posts_path
  end
end
