class PostController < ApplicationController
  before_action :authorize, except: [:index]
  def index
    @posts=PostList.all
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
    post.update(title: params[:title],user_id: post.user_id , text: params[:text])
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
    Comment.create(name: params[:name], comm: params[:text], post_list_id: params[:id],user_id: current_user.id )
    redirect_to :back
  end
  def comdel
    comment = Comment.find(params[:id])
    post = comment.post_list_id
    if comment.user_id==current_user.id
      comment.destroy
    end
    redirect_to "/post/show/#{post}"
  end
  def comedit
    @comm=Comment.find(params[:id])
    if @comm.user_id == current_user.id

    else
      redirect_to "/post/show/#{@comm.post_list_id}"
    end
  end
  def comupdate
    comm=Comment.find(params[:id])
    comm.update(name: params[:name], comm: params[:text], post_list_id: comm.post_list_id)

    redirect_to "/post/show/#{comm.post_list_id}"
  end


end
