require 'sinatra'
require 'sinatra/reloader'
require 'data_mapper' # metagem, requires common plugins too.

# need install dm-sqlite-adapter
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/blog.db")
#datamapper를 쓸건데 default 쓸거고 dir을 현재 디렉토리 밑에 쓸거다
class Post   #테이블 이름 Post.
  #property가 각 열 정보. 이름, 속성
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :text, Text
  property :created_at, DateTime
end

class User
  include DataMapper::Resource
  property :id, Serial
  property :email, String
  property :pwd, Text
  property :created_at, DateTime
end
# Perform basic sanity checks and initialize all relationships
# Call this when you've defined all your models
DataMapper.finalize
# automatically create the post table
Post.auto_upgrade!
User.auto_upgrade!

set :bind, '0.0.0.0'
before do
  p "*********************************"
  p params
  p "*********************************"
end
get '/' do
  @posts = Post.all.reverse  #Post에 저장된 모든걸 가져옴
  erb :index
end

# Model (DB) - SQL
# C-R-U-D
# C : Create ex) 게시글 작성
# R : Read   ex)게시판 목록/ 하나의 게시글
# U : Update  ex) 게시글 수정
# D : Destroy  ex) 게시글 삭제

get '/complete' do
@title = params[:title]
@text = params[:text]
  Post.create(:title => @title, :content => @content)
  # Post.create(title: @title, content: @content)
  erb :complete
end

get '/post' do
  erb :post
end


get '/signup' do
  erb :signup
end

get '/usercomplete' do
  @email=params[:email]
  @pw=params[:pwd]
  User.create(email:@email, pwd:@pw)
  erb :usercomplete
end

get '/users' do
  @users=User.all.reverse
  erb :users
end
