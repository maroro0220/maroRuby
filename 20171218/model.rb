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
