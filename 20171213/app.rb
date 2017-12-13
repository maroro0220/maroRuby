require 'sinatra'
require 'sinatra/reloader'
require 'csv'
require 'date'

before do
    p "*********************************"
    p params
    p "*********************************"
end
get '/' do
  send_file "index.html"
end
#code
#/post => 글쓸 수 있는 곳
get '/post' do
  erb :post
end

get '/complete' do

  @title=params[:title]
  @txt=params[:text]
  CSV.open('txtboard.csv','a+:utf-8') do |csv|
    csv << ["Write Time",Time.now.to_s,"title: ",@title.to_s,"text: ",@txt]
    # csv << [@title, @txt]
  end
  erb :complete
end

get '/posts' do
  @posts = []
  CSV.foreach('txtboard.csv',encoding: 'utf-8') do |row|
    @posts << row#append느낌 하나씩 뒤에 넣어주는거
  end
  erb :posts
end

get '/signup' do
  erb :signup
end

get '/signups' do
  @sign=[]
  CSV.foreach('signup.csv',encoding: 'utf-8') do |c|
    @sign << c
  end
  erb :signups
end

get '/completes' do
  @email=params[:email]
  @name=params[:name]
  @id=params[:ID]
  @pw=params[:PW]
  @pw2=params[:PW2]

      if @pw==@pw2
        CSV.open('signup.csv','a+:utf-8') do |c|
          c << [Time.now.to_s,@email,@name,@id,@pw]
        end
            erb :completes
    else
      redirect '/signup'
    end

end

#/complete => 글 완료 페이지
