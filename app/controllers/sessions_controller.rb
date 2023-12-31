class SessionsController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :not_sessions_new_if_logged_in, only: [:new]

  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to posts_path
    else
      flash[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end

  private

  def not_sessions_new_if_logged_in
    redirect_to posts_path if logged_in?
    flash[:notice] = '既にログインしています' 
  end
end
