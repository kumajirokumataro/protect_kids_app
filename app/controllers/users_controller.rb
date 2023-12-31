class UsersController < ApplicationController
  #before_action :not_currentuser_notadmin_newpath, {only: [:new]}
  #before_action :not_currentuser_notadmin_path, {only: [:show, :edit]}
  #destroyとupdateは入れるべきか？
  skip_before_action :login_required, only: [:new, :create]
  before_action :not_users_new_if_logged_in, only: [:new]

  def new
    @user = User.new
  end

  def create
     @user = User.new(user_params)
    if @user.save
      redirect_to new_session_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    binding.pry
    @user = User.find(params[:id])
    @user.update!(user_params)
    redirect_to posts_path 
    flash[:notice] = '編集しました！'
  end
  
  def show
    @user = User.find(params[:id])
  end

  private

  def not_users_new_if_logged_in
    redirect_to posts_path if logged_in?
    flash[:notice] = '既にログインしています'
  end
    

    #def not_currentuser_notadmin_newpath
      #if current_user && current_user.admin == false
        #flash[:notice]="既に会員登録しています"
        #redirect_to user_path(current_user.id)
      #end
    #end

    #def not_currentuser_notadmin_path
      #if current_user.id != params[:id].to_i && current_user.admin == false
        #current_user != User.find(params[:id]) でもうまくいく。railsが全体のデータの中からIDを取得して検証してくれるので。
        #flash[:notice]="本人と管理者以外はアクセスできません"
        #redirect_to tasks_path
      #end
    #end
end
