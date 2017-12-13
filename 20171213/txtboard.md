### 게시판 만들기

---

#####1. app.rb =>  controller 

#####2. index.html => main page

#####3. post.erb => enter text page

#####4. complete.erb => result print page

------------



app.rb에 아래 소스 추가하면 넘어다니는 parameter들 bash창에 출력

```ruby
before do
    p "*********************************"
    p params
    p "*********************************"
end
```

root page에 연결

```ruby
get '/' do
  send_file "index.html"
end
```

같은 폴더에 views폴더 만들고

post.erb, complete.erb 생성 후 

```ruby
get '/post' do
  erb :post
end

get '/complete' do

  @title=params[:title]
  @txt=params[:text]
  CSV.open('txtboard.csv','a+') do |csv|
    csv << ["Write Time",Time.now.to_s,"title: ",@title.to_s,"text: ",@txt]
  end
  erb :complete
end
```

complete로 들어갈 title, text parameter post에서 받아옴

```html
<form action="/complete">
      <h4>제목 : <br /><input type="text" name="title" size="100"/></h4>
      <h4>글 :</h4>
      <textarea name="text" rows="30" cols="100"></textarea><br />
      <input type="submit" value="save"/>
    </form>
```

action으로 다음 글 보여줌

parameter로 넘길 값들은 name으로 지정

```html
   <h4>your email : <%= @email%></h4>
    <h4>your name : <%= @name%></h4>
    <h4>your ID: <%= @id%></h4>
    <h4>yout pw: <% @pw.length.times do %> * <%end%> </h4>
```

넘겨 받은 parameter들을 @를 사용하여 활용

