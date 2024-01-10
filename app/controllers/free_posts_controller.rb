class FreePostsController < ApplicationController
    skip_before_action :login_required, only: [:index, :show]
    before_action :not_edit, only: [:edit]
   
  
      def index
        @freeposts = FreePost.all
        if params[:search].present?
          if params[:search][:title] && params[:search][:target_child_age].present?
            @freeposts = FreePost.search(params[:search][:title], params[:search][:target_child_age])
          elsif params[:search][:title]
            @freeposts = FreePost.title_search(params[:search][:title])
          elsif params[:search][:target_child_age]
            @freeposts = FreePost.target_child_age_search(params[:search][:target_child_age])
          end
        end
  
        #@task = Task.new
    
        #@tasks = @tasks.page(params[:page]).per(15)
    
      end
    
      def show
        @freepost = FreePost.find(params[:id])
        #@comments = @post.comments
        #@comment = @post.comments.build
      end
    
      def new
        @freepost = FreePost.new
      end
    
      def create
        @freepost = current_user.free_posts.build(free_post_params)
          # if @post.save
          #   ShareMailer.share_mail(@post).deliver 
          #   redirect_to posts_path, notice: "投稿を作成しました！"
          # else
          #   render :new
          # end
        
      end
    
      def edit
        @freepost = FreePost.find(params[:id])
      end
    
      def update
        @freepost = FreePost.find(params[:id])
        if @freepost.update(free_post_params)
          redirect_to free_posts_path, notice: "編集しました！"
        else
          render :edit
        end
      end
    
      def destroy
        @freepost = FreePost.find(params[:id])
        @freepost.destroy
        redirect_to free_posts_path, notice:"削除しました！"
      end
    
      private
    
      def free_post_params
        params.require(:freepost).permit(:title, :content, :kind, :target_child_age)
      end
  
      def not_edit
        if current_user == false && current_user.admin == false
          redirect_to free_posts_path, notice:"編集できません！"
        end
      end 
end
  