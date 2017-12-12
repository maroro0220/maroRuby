require 'sinatra'
require 'sinatra/reloader'
require 'csv'
require 'date'
#크롤링을 위한 gem
require 'nokogiri'
require "httparty"
require "uri"
get '/' do
  erb :index
end
get '/welcome/:name' do
  @name=params[:name]
  @time=Time.now.to_s
  #csv는 require 'csv'
  CSV.open('user.csv','a+') do |csv|
    #time.now를 쓰려면 require 'date'
    csv << [@name.to_s,@time]
  end
  erb :welcome
end
get '/users' do
  @users=[]
  CSV.foreach('user.csv') do |row|
    @users << row
  end
  erb :users
  #꼭 매칭 해야하는건 아님
end
get '/lolfinder' do
  erb :lolfinder
end
get '/lol' do
  @username=params[:username]
  url="http://www.op.gg/summoner/userName=#{@username}"
  url=URI.encode(url)
  response=HTTParty.get(url)
  doc=Nokogiri::HTML(response)
  @win=doc.css("#SummonerLayoutContent > div.tabItem.Content.SummonerLayoutContent.summonerLayout-summary > div.SideContent > div.TierBox.Box > div.SummonerRatingMedium > div.TierRankInfo > div.TierInfo > span.WinLose > span.wins")
  @lose=doc.css("#SummonerLayoutContent > div.tabItem.Content.SummonerLayoutContent.summonerLayout-summary > div.SideContent > div.TierBox.Box > div.SummonerRatingMedium > div.TierRankInfo > div.TierInfo > span.WinLose > span.losses")
  # @win=doc.css("#GameAverageStatsBox-summary > div.Box > table > tbody > tr:nth-child(1) > td:nth-child(1) > div > span.win")
  # @lose=doc.css("#GameAverageStatsBox-summary > div.Box > table > tbody > tr:nth-child(1) > td:nth-child(1) > div > span.lose")
  erb :lol
end
get '/vote' do
  erb :vote
end
get '/result' do
  @res=params[:count]
  CSV.open('vote.csv','a+') do |v|
    v << [@res.to_s]
  end
  erb :result
end
