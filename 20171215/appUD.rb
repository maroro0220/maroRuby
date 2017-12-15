require 'sinatra'
require 'sinatra/reloader'
require 'data_mapper'
require 'date'
DataMapper::setup(:default,"sqlite3://#{Dir.pwd}/blog.db")

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
  property :created_at, DateTime
end
DataMapper.finalize
Post.auto_upgrade!
set :bind, '0.0.0.0'
before do
  p '********************'
  p "params"
  p '********************'
end

get '/' do
  @p=Post.all.reverse
  erb :indexUD
end

get '/newUD' do
  erb :newUD
end

get '/createUD' do
  @title = params[:title]
  @txt= params[:text]
  @date= Time.now+9*60*60
  Post.create(title:@title, text:@txt, created_at:@date)
  redirect '/'
end

get '/postsUD/:id' do
  @p=Post.get(params[:id])
  erb :postsUD
end

get '/destroyUD/:id' do
  id=Post.get(params[:id])
  id.destroy
  redirect '/'
end

get '/editUD/:id' do
  @p=Post.get(params[:id])
  erb :editUD
end

get '/updateUD/:id' do
  post=Post.get(params[:id])
  # post.update(:title => params[:title], :text => params[:text])
  post.update(title:params[:title], text:params[:text])
  #Post.get(params[:id]).update(title:params[:title], text:params[:text])
  redirect '/'
end
