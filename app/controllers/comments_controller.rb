class CommentsController < ApplicationController
  before_action :set_post, only: [:create, :edit, :update]
  before_action :not_edit_destroy_admin, only: [:edit, :update, :destroy]
  #updateとdestroyを入れるか迷ったけど、ブラウザ上以外でも更新できてしまうので、必ず入れるべき、とのこと！
  before_action :not_create_user, only: [:create]

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        format.js { render :index }
      else
        flash.now[:notice] = '投稿できませんでした'
        format.js { render :index }
      end
    end
  end

  def edit
    @comment = @post.comments.find(params[:id])
    respond_to do |format|
      flash.now[:notice] = 'コメントの編集中'
      format.js { render :edit }
    end
  end

  def update
    @comment = @post.comments.find(params[:id])
      respond_to do |format|
        if @comment.update(comment_params)
          flash.now[:notice] = 'コメントが編集されました'
          format.js { render :index }
        else
          flash.now[:notice] = 'コメントの編集に失敗しました'
          format.js { render :edit }
        end
      end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      flash.now[:notice] = 'コメントが削除されました'
      format.js { render :index }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def not_edit_destroy_admin
    if current_user == false 
      redirect_to posts_path, notice: "権限がありません！"
    elsif current_user && current_user.admin == false
      redirect_to posts_path, notice: "権限がありません！"
    end
  end

  def not_create_user
    if current_user == false 
      redirect_to posts_path, notice: "権限がありません！"
    end
  end

end
