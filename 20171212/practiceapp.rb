require 'sinatra'
require 'sinatra/reloader'
require 'csv'
get '/' do
  erb :indexp
end

get '/votep' do
  erb :votep
end

get '/resultp' do
  @resp=params[:v]
  CSV.open('votep.csv','a+') do |v|
    v << [@resp.to_s]
  end
  erb :resultp
end
