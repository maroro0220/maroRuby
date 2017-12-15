require 'sinatra'
require 'sinatra/reloader'
require 'data_mapper' #orm 객체 관계형 맵퍼.https://ko.wikipedia.org/wiki/%EA%B0%9D%EC%B2%B4_%EA%B4%80%EA%B3%84_%EB%A7%A4%ED%95%91

#DataMapper를 사용하는데, db파일을 현재 경로에 blog2.db라고 저장한다
DataMapper::setup(:default,"sqlite3://#{Dir.pwd}/blog2.db")

#post라는 클래스를 만들고, db(table)를 만든다.
#머리에 엑셀 띄우기
class Post
  include DataMapper::Resource
  #id는 고유한 값이고, 저장할 수록 1부터 하나씩 증가한다.
  property :id, Serial#serial이 하나씩 있어야함
  #title은 string 타입. text보다 짧은 문자열
  property :title, String #50자
  #text는 text타입. string보다 많이 긴 문자열.  65535자
  property :text, Text #text는 더 길게 가능.
  #(자동) 날짜 시간을 저장한다. date, time도 따로 나눠서 할 수 있음.
  property :date, DateTime
end

class User
  include DataMapper::Resource
  property :id, Serial
  property :email, String
  property :pwd, String
  property :date, DateTime
end
#너의 model(dn)
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
get '/posts/:id' do
  @post=Post.get(params[:id])
  erb :posts
end

#CRUD -'D'
get '/destroy/:id' do
  pid=Post.get(params[:id])
  pid.destroy

  redirect '/'
end

#CRUD - 'U'
#1.사용자에게 form을 입력받는 창
get '/edit/:id' do
  @post = Post.get(params[:id])
  erb :edit
end

get '/update/:id' do
  post = Post.get(params[:id])
  post.update(:title => params[:titlee],:text => params[:texta])
  redirect '/'
end

get '/welcome/:name' do
  @name=params[:name]
  erb :welcome
end
