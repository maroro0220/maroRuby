class PostController < ApplicationController
  def index
     @posts = Post.all.reverse
  end

  def new
  end

  def create
    #1번방법
    Post.create(:username => params[:username],
      :title => params[:title], :text => params[:text])
    #1-2
    # Post.create(username: params[:username], title: params[:title])

    #2번 방법
    # post = Post.new
    # post.username = params[:username]
    # post.title = params[:title]
    # post.text = params[:text]
    # post.save

    redirect_to '/'
  end

  def show
      #어떤 글을 보여주겠다.
      #@변수를 통해서 erb 파일에서 보여줌
      @post=Post.find(params[:id])
      #id는 routes에서 주소로 받아올 떄 쓰는거
  end

  def destroy
    post=Post.find(params[:id])
    post.destroy
    redirect_to '/'
  end

  def edit
    @post=Post.find(params[:id])
  end

  def update
    post=Post.find(params[:id])

    #방법1
    post.update(username: params[:username], title: params[:title], text: params[:text])
    #post.update(:username => params[:username], :title => params[:title], :text => params[:text])

    #방법2
    #post.username =params[:username]
    #post.title=params[:title]
    #post.text=parmas[:text]
    #post.save

    redirect_to "/post/show/#{params[:id]}"
  end
end
