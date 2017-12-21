class PostController < ApplicationController
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
    name=params[:name]
    text=params[:text]
    PostList.create(title: title, name: name, text: text)
    redirect_to '/'
  end

  def update
    post=PostList.find(params[:id])
    post.update(title: params[:title],name: params[:name], text: params[:text])
    redirect_to '/show/#{params[:id]}'
  end

  def destroy
    post=PostList.find(params[:id])
    post.destroy
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
    redirect_to "/show/#{post}"
  end
  def comedit
    
  end

end
