class UsersController < ApplicationController
  before_action :not_currentuser_notadmin_newpath, {only: [:new]}
  before_action :not_currentuser_notadmin_path, only: [:edit, :update, :destroy]
  skip_before_action :login_required, only: [:new, :create, :show]
  before_action :not_users_new_if_logged_in, only: [:new] 

  
  def new
    @user = User.new
  end

  def create
     @user = User.new(user_params)
    if @user.save
      redirect_to new_session_path, alert: 'アカウント登録完了しました！'
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update!(user_params)
    redirect_to posts_path, alert: '編集しました！'
  end
  
  def show
    @user = User.find(params[:id])
  end

  private

  def not_users_new_if_logged_in
    if logged_in?
      redirect_to posts_path, alert: '既にログインしています'
    end
  end
    

  def not_currentuser_notadmin_newpath
    if current_user && current_user.admin == false
      redirect_to user_path(current_user), alert: '既に会員登録しています'
    end
  end

  def not_currentuser_notadmin_path
    if current_user.id != User.find(params[:id]).id && current_user.admin == false
       redirect_to posts_path, alert: '本人と管理者以外はアクセスできません'
    end
  end
end
