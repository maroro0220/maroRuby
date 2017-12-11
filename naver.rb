#gem을 사용하기 위해 불러온다.
# 요청을 보내기 위한 httparty
require 'httparty'
#원하는 정보를 가져오기 위한 nokogiri
require 'nokogiri'

#1. 네이버 국내 증시 주소를 url에 저장한다.
url="http://sports.news.nate.com/view/20171208n17329"
#2. url을 통해서 요청한다.
response=HTTParty.get(url)
#3. 가져온 문서를 nokogiri 형식으로 저장한다. for 컴퓨터
doc=Nokogiri:: HTML(response)
#4. 문서에서 css중 ID가 KOSPI_now 인것을 kospi라는 변수 에 저장.
#css를 가져오기 위해서 크롬에서 copy selector
#kospi=doc.css("#newsEndContents")
kospi=doc.css("#livePhotoList1 > ul > li:nth-child(3) > a > strong")
#5.kospi에 저장된 것 중에서 태그 안에 있는 텍스트를 출력한다.
puts kospi.text
#nokogiri에서 문법 안에 내용들? 을 가져오려면 .text를 씀
