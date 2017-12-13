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

action으로 다음 글 넘겨주고 csv파일에 저장

```ruby
  @title=params[:title]
  @txt=params[:text]
  CSV.open('txtboard.csv','a+:utf-8') do |csv|
    csv << ["Write Time",Time.now.to_s,"title: ",@title.to_s,"text: ",@txt]
    # csv << [@title, @txt]
  end
  erb :complete
end
```

complete에서 글 목록 보기를 누르면 /posts로 app.rb를 거쳐서 넘어감

이때 csv에 저장된 글 목록들을 같이 넘겨줌

```ruby
  @posts = []
  CSV.foreach('txtboard.csv',encoding: 'utf-8') do |row|
    @posts << row#append느낌 하나씩 뒤에 넣어주는거
  end
  erb :posts
```



받아온 글 목록을 역순으로 뒤집고 하나씩 index와 함께 빼냄

```ruby
<!-- index랑 같이 보여주기 : each_with_index -->
<!-- 역순으로 보여주기 : reverse -->
<% @posts.reverse.each_with_index do |post, idx| %>
  <%= @posts.length - idx %> 번째 글 <br />
  제목 : <%= post[3] %> <br />
  내용 : <%= post[5] %>
  <hr />
<% end %>
```





-----

# 유저등록

글 등록과 유사.



parameter로 넘길 값들은 name으로 지정

```html
   <h4>your email : <%= @email%></h4>
    <h4>your name : <%= @name%></h4>
    <h4>your ID: <%= @id%></h4>
    <h4>yout pw: <% @pw.length.times do %> * <%end%> </h4>
```

넘겨 받은 parameter들을 @를 사용하여 활용

app을 거쳐서 complets로 넘어감 

넘어갈 떄 

complets에서 pw와 pw2비교해서 같으면 csv에 저장하고 completes로 넘어감

 ```ruby
      if @pw==@pw2
        CSV.open('signup.csv','a+:utf-8') do |c|
          c << [Time.now.to_s,@email,@name,@id,@pw]
        end
            erb :completes
    else
      redirect '/signup'
    end
 ```

---

