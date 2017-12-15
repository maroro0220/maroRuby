### CRUD

---

###### DataMapper로 sqlite3랑 sinatra 이어줌

post라는 클래스를 만들고, db(table)를 만든다.

```ruby
class Post

  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :text, Text
  property :date, DateTime
end
DataMapper.finalize
Post.auto_upgrade! #이걸 해줘야 db가 생성. 위에 class 만든다고 마들어지는게 아님

set :bind, '0.0.0.0'
```

id는 고유한 값이고, 저장할 수록 1부터 하나씩 증가한다.

title은 string 타입. text보다 짧은 문자열

text는 text타입. string보다 많이 긴 문자열.  65535자

(자동) 날짜 시간을 저장한다. date, time도 따로 나눠서 할 수 있음.



```ruby
get '/' do
  @p=Post.all.reverse
  erb :indexUD
end
```

Post(DB)에서 저장된 값들을 다 가져와서 

p를 indexUD에서 사용할거라 @ 붙여줌

최신글이 제일 위에 보여야 함으로 reverse해줌 



indexUD에서 아래처럼 처리해서 글 id랑 title등을 출력해줌

```erb
  <% @p.each do |p| %>
  <p> <%= p.id %><br /> </p>
  <p> <%= p.title %><br /> </p>
  <p> <%= p.text %><br /> </p>
  <p> <%= p.created_at %><br /> </p>
  <p> <a href="/postsUD/<%= p.id%>">글보러가기</a> </p>
  <p> <a href="/destroyUD/<%= p.id%>"> 삭제 </a> </p>
  <p> <a href="/editUD/<%= p.id%>"> 수정 </a> </p>
  <% end %>
```

p.id는 루비 문법.

""안에 있어도 ""처리하기 전에 루비문법부터 처리해서 글의 id값 읽어옴

id는 primary key여서 한개씩만 존재. 그 id(key)가지고 각 글에 접근할 수 있음

---



### 생성Create

/newUD에서 글쓰기 하면 /createUD로 보내는 것이 아니라 Post(DB)에 값들을 저장.

params에 들어있는 값들은 newUD에서 전달 받은 name, 값들.

```ruby
get '/createUD' do
  @title = params[:title]
  @txt= params[:text]
  @date= Time.now+9*60*60
  Post.create(title:@title, text:@txt, created_at:@date)
  redirect '/'
end
```

---



### 읽기 Read

```ruby
get '/postsUD/:id' do
  @p=Post.get(params[:id])
  erb :postsUD
end
```

id까지 같이 받아옴 

/postsUD   글 보여주기

```erb
<p>id: <%= @p.id%></p>
<p>date: <%= @p.created_at%></p>
<p>title: <%= @p.title%></p>
<p>text: <%= @p.text%></p>
<a href="/"> Go back to home</a>
```

---



### 수정 Update

두 단계 거침.

edit을 위해 기존 값들을 포함한 textarea 띄워주는 /editUD

수정한 값을 저장하는 /updateUD

해당 글의 id에 해당하는 db 정보들을 @p로 넘겨줌

```ruby
get '/editUD/:id' do
  @p=Post.get(params[:id])
  erb :editUD
end

get '/updateUD/:id' do
  post=Post.get(params[:id])
  # post.update(:title => params[:title], :text => params[:text])
  post.update(title:params[:title], text:params[:text])
  #Post.get(params[:id]).update(title:params[:title], text:params[:text])
  redirect '/'
end
```



/editUD

```erb
  <form action="/updateUD/<%=@p.id%>">
      <h4>제목 : <br /><input type="text" name="title" size="100" value="<%= @p.title%>" /></h4>
      <h4>글 :</h4>
      <textarea name="text" rows="30" cols="100"><%=@p.text%></textarea><br />
      <input type="submit" value="edit"/>
    </form>
```

newUD랑 비슷한데 submit을 하면 /updateUD에 @p.id랑 같이 전달해줌

그리고 기존 내용 뭔지 알아야하니깐 출력. 

기존 값들 출력하는 것도 @p.title, @p.text를 활용.



그리고 /updateUD도 /createUD랑 비슷함

erb파일이 있는게 아니라 Post(DB)에 값을 저장해줌.

Create에서는 새로 생성이고 update에서는 수정

그런데 다른 점은 update는 해당 글의 id를 Post.get()에 넣어서 그 글을 post로 가져오고

post.update()로 수정해줌. 

params[:title], params[:text]는 /editUD에서 넘겨준 값들의 name들.

name="titleeeee"로 넘겨줬으면 params[:titleeeee] 이렇게 설정

title:params[:title]은 해쉬 형태.

 :title => params[:title]로도 가능

앞에 :title은 위에 class Post 정의하면서 설정해준 이름.

```ruby
  property :title, String
```



---

### 삭제 Destroy, Delete

/destroyUD/<%= p.id%> 삭제도 똑같이 id값 같이 넘겨받음

```ruby
get '/destroyUD/:id' do
  id=Post.get(params[:id])
  id.destroy
  redirect '/'
end
```

.destroy는 삭제 해주는거 해당 글의 id를 params로 넘겨 받아서 Post에 저장되어 있는 id에 해당하는 값들을 삭제