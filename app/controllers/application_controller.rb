class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :login_required

  def login_required
    redirect_to new_session_path unless current_user
    flash[:notice] = 'ログインしてください。又はログインユーザーでなければ入れません'
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :gender, :age, :nickname, :self_introduction, :admin, { area_ids: [] }  )
  end

end
