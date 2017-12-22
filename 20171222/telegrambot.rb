require 'rest-client'
# require 'httparty'
require 'uri'
require 'nokogiri'
require 'json'

url = "https://api.telegram.org/bot"
token = "456853143:AAHlbZHsyzwvaIanqJZoygr2Krh2DI3PjqY"
get_id_url="#{url}#{token}/getupdates"

response=RestClient.get(get_id_url) #요청보내서 받아옴
# response=HTTParty.get(url) #요청보내서 받아옴
# puts response.body
hash=JSON.parse(response.body)

chat_id=hash["result"][0]["message"]["from"]["id"]
####################
# res_lotto=RestClient.get("http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=785")
# lotto_hash=JSON.parse(res_lotto)
# lotto_result=[]
# 6.times do |i|
#   lotto_result << lotto_hash["drwtNo#{i+1}"]
# end

#(1..45).to_a.sample(6)
# msg=lotto_result.to_s + "#{(1..45).to_a.sample(6)}"


msg="Lotto 추천: "+(1..45).to_a.sample(6).to_s
#######################
# msg=_______________
msg_url="#{url}#{token}/sendMessage?chat_id=#{chat_id}&text=#{msg}"
RestClient.get(URI.encode(msg_url))
