#브라우저 오픈과 관련된 gem을 불러온다
require 'launchy'
#검색어 배열을 만든다
idol=["a","b","cd","efg"]
#검색 url을 저장한다.
url = "https://search.naver.com/search.naver?where=nexearch&query="
#반복한다
idol.each do |name|
  Launchy.open(url+name)
end
