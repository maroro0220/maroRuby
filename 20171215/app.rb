require 'sinatra'
require 'sinatra/reloader'
require 'data_mapper' #orm 객체 관계형 맵퍼.https://ko.wikipedia.org/wiki/%EA%B0%9D%EC%B2%B4_%EA%B4%80%EA%B3%84_%EB%A7%A4%ED%95%91

DataMapper::setup(:default,"sqlite3://#{Dir.pwd}/blog2.db")
class Post
  include DataMapper::Resource
  property :id, Serial#serial이 하나씩 있어야함
  property :title, String #255까지만됨
  property :text, Text #text는 더 길게 가능.
  property :date, DateTime
end

class User
  include DataMapper::Resource
  property :id, Serial
  property :email, String
  property :pwd, String
  property :date, DateTime
end
DataMapper.finalize
Post.auto_upgrade! #이걸 해줘야 db가 생성. 위에 class 만든다고 마들어지는게 아님
User.auto_upgrade!

set :bind, '0.0.0.0'
before do
  p '********************'
  p "params"
  p '********************'
end

get '/' do
  @p=Post.all.reverse
  erb :index
end

get '/new' do
  erb :new
end

get '/create' do
  #이거는 form에서 넘어오는거. name으로 설정된 것.
  @title=params[:title]
  @text=params[:text]

  #db에 저장.
  #title, text는 위에서 DataMapper에 설정한 내용
  # post라는 table의 column에 해당하는 것
  Post.create(title:@title, text:@text)
  # erb :complete
  redirect '/'
end
