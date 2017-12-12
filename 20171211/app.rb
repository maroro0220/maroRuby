require 'sinatra'


#http://localhost:4567/
#get ????  '/'루트, 루트 페이지
get '/' do
  send_file 'index.html'
end


#http://localhost:4567/welcome
get "/welcome" do
  send_file "welcome.html" #welcome.html이 파일을 보내줘
end

#url에 :name을 쓰면 params[:name]으로 받ㅇ를 수 있다.
#예시) /welcome/maro params[:name]=="maro"
get '/welcome/:name' do#  #http://localhost:4567/welcome/문자 문자를 파라미터로 받겠다
  @name=params[:name]       #params도 약속임. parameter. @는 @를 해야 다른데 넘겨줄 수 있음.
  erb :welcome
end

#get '/:num' do
get 'squre/:num' do
  @num=params[:num]
  erb :welcome
end
get '/6' do
  erb :hello #symbol
end

get '/lotto' do
  @lotto = (1..45).to_a.sample(6)
  erb :lotto
end

#이걸로 해보기
get '/s' do
  erb :s
end

get '/search' do
 @q = params[:query]#query 이거가 s.erb에서 name 이랑 맞춰줘야함
 @name = params[:name]
erb :search
end

get '/lunch' do
  @lunch = ["멀캠20층", "순시", "명칼", "시골집"].sample
  @img_url = {
    "멀캠20층"=>"http://cfile3.uf.tistory.com/original/181426234C21898E1B71D9",
    "순시"=> "https://pbs.twimg.com/media/DIsHAnDUEAAAh1U.jpg",
    "명칼"=>"http://www.lanaver.com/data/file/B11/1654306616_J9GodvLs_EABEB8EBAFB8EAB8B0_l__1_.jpg",
    "시골집" =>"http://postfiles5.naver.net/MjAxNzA3MjdfNjAg/MDAxNTAxMTQxOTQ3OTE4.32K_Xj2CmHauTVI4N6Pw9Qf1DW_A8w7XhbwC8iodKrMg.cHM1Kn0Is99E4YM_Rd4kldsWlQ1Tx8Zh0QDEPtJ4bQkg.JPEG.hsk3207/20170626_120626.jpg?type=w966"
  } 
  erb :lunch
end
