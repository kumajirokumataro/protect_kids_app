class PostsController < ApplicationController
  skip_before_action :login_required, only: [:index, :show]
  before_action :not_edit, only: [:edit]
 

    def index
      @posts = Post.all.order(created_at: "DESC")
    end
    
    def show
      @post = Post.find(params[:id])
      @comments = @post.comments
      @comment = @post.comments.build
    end
  
    def new
      @post = Post.new
    end
  
    def create
      @post = current_user.posts.build(post_params)
      @post.area_id = Area.find_by(name: params[:post][:name]).id
      
        if @post.save
          ShareMailer.share_mail(@post).deliver 
          redirect_to posts_path, notice: "投稿を作成しました！"
        else
          render :new
        end
      
    end
  
    def edit
      @post = Post.find(params[:id])
    end
  
    def update
      @post = Post.find(params[:id])
      if @post.update(post_params)
        redirect_to posts_path, notice: "編集しました！"
      else
        render :edit
      end
    end
  
    def destroy
      @post = Post.find(params[:id])
      @post.destroy
      redirect_to posts_path, notice:"削除しました！"
    end
  
    private
  
    def post_params
      params.require(:post).permit(:title, :content, :type, :latitude, :longitude)
    end

    def not_edit
      if current_user && current_user.admin == false
        redirect_to posts_path, notice:"編集できません！"
      end
    end 
end



