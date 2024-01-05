class SessionsController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :not_sessions_new_if_logged_in, only: [:new]

  def new
    #@user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email].downcase)
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to posts_path
    else
      flash[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    binding.pry
    session.delete(:user_id)
    redirect_to new_session_path, notice: 'ログアウトしました'
  end

  private

  def not_sessions_new_if_logged_in
    if logged_in?
      redirect_to posts_path 
      flash[:notice] = '既にログインしています' 
    else
      flash[:notice] = 'ログイン画面です！'
    end
  end
end
