class FreePostsController < ApplicationController
    skip_before_action :login_required, only: [:index, :show]
    before_action :not_edit, only: [:edit]
   
  
      def index
        @freeposts = Free_post.all
        #if params[:task].present?
          #if params[:task][:name] && params[:task][:status].present?
            #@tasks = current_user.tasks.search(params[:task][:name], params[:task][:status])
            #sucopeを使用しなかった時の書き方@tasks = Task.where('name LIKE ?', "%#{params[:task][:name]}%").where(status: params[:task][:status])
            #モデル名.where(A).or(モデル名.where(B))
          #elsif params[:task][:name]
            #@tasks = current_user.tasks.name_search(params[:task][:name])
          #elsif params[:task][:status]
            #@tasks = current_user.tasks.status_search(params[:task][:status])
          #elsif params[:task][:id]
            #label = Label.find(params[:task][:id])
            #label_task_id = label.connections.pluck(:task_id)
            #@tasks = Task.where(id: label_task_id)
          #end
        #end
  
        #if params[:sort_expired]
          #@tasks = current_user.tasks.all.order(timelimit: "ASC")
        #elsif params[:sort_rank]
          #@tasks = current_user.tasks.all.order(rank: "ASC")
        #elsif params[:task]
          #@tasks = @tasksということ（検索機能で絞られたタスクがそのまま、ということ）
        #elsif 
          #@tasks = current_user.tasks.all.order(created_at: "DESC")
        #end
    
        #@task = Task.new
    
        #@tasks = @tasks.page(params[:page]).per(15)
    
      end
    
      def show
        @freepost = Free_post.find(params[:id])
        #@comments = @post.comments
        #@comment = @post.comments.build
      end
    
      def new
        @freepost = Free_post.new
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
        @freepost = Free_post.find(params[:id])
      end
    
      def update
        @freepost = Free_post.find(params[:id])
        if @freepost.update(free_post_params)
          redirect_to free_posts_path, notice: "編集しました！"
        else
          render :edit
        end
      end
    
      def destroy
        @freepost = Free_post.find(params[:id])
        @freepost.destroy
        redirect_to free_posts_path, notice:"削除しました！"
      end
    
      private
    
      def free_post_params
        params.require(:post).permit(:title, :content, :group, :target_child_age)
      end
  
      def not_edit
        if current_user && current_user.admin == false
          redirect_to free_posts_path, notice:"編集できません！"
        end
      end 
end
  