class GuestsessionsController < ApplicationController
  skip_before_action :login_required, only: [:new_guest]
  
  
  def new_guest
    user = User.find_or_create_by(email: 'guest@gmail.com') do |user|
      user.name = 'ゲストユーザー'
      user.nickname = 'ゲスト'
      user.password = '111111'
    end
    session[:user_id] = user.id
    binding.pry
    flash[:notice] = 'ゲストユーザーとしてログインしました'
    redirect_to posts_path
  end
end
