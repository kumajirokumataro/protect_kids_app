class Admin::UsersController < ApplicationController
  before_action :not_admin_path

  def not_admin_path
    if current_user.admin == false
      flash[:notice]="管理者以外はアクセスできません"
      redirect_to main_app.root_path
    end
  end
end
