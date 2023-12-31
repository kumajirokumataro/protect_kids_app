class PostsController < ApplicationController
  skip_before_action :login_required, only: [:index, :show]
  before_action :not_edit, only: [:edit]

    def index
      @posts = Post.all
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
      @post = Post.find(params[:id])
    end
  
    def new
      @post = Post.new
    end
  
    def create
      @post = current_user.posts.build(post_params)
      @post.area_id = Area.find_by(name: params[:post][:name]).id
      
      #@task = current_user.tasks.build(task_params)
      #この上の1行は、この2行のこと
      #@task = Task.new(task_params)
      #@task.user_id = current_user.id 
  
        if @post.save!
          binding.pry
          redirect_to posts_path, notice: "投稿を作成しました！"
        else
          render :new
        end
      #end
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
