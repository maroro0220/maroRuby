class PostController < ApplicationController
  before_action :authorize, except: [:index]
  def index
    @post=PostList.all
  end

  def edit
    @post=PostList.find(params[:id])
  end

  def new
  end

  def create
    title=params[:title]
    user=User.find(session[:user_id])
    text=params[:text]
    PostList.create(title: title, user_id: user.id, text: text)
    redirect_to '/'
  end

  def update
    post=PostList.find(params[:id])
    post.update(title: params[:title],user_id: current_user.id, text: params[:text])
    redirect_to "/post/show/#{params[:id]}"
  end

  def destroy
    post=PostList.find(params[:id])
    if post.user_id==current_user.id
      post.destroy
    end
  redirect_to '/'
  end

  def show
    @p=PostList.find(params[:id])
    @c=Comment.all
  end
  def add_comment
    Comment.create(name: params[:name], comm: params[:text], post_list_id: params[:id] )
    redirect_to :back
  end
  def comdel
    comment = Comment.find(params[:id])
    post = comment.post_list_id
    comment.destroy
    redirect_to "/post/show/#{post}"
  end
  def comedit
    @comm=Comment.find(params[:id]) 
  end

end
