## 정보 숨겨서 전달

---

form에서 아무것도 설정 안해주면 get방식으로 설정되는데 그러면 어떤 정보들이 넘어가는지 주소창에 다 보임.

그래서 post방식으로 넘겨줘야함.

그리고 hidden을 만들어줘야함.

```html
<form action="/create"  method="post">
  
  <input type="hidden" name="authenticity_token"  value="<%= form_authenticity_token %>"/><br />

```

hidden에 name이랑 value는 약속. 바꾸면 안됨.

저게 토큰을 만들어 주는거.



routes.rb에서도 get을 post로 바꿔줘야함

```ruby
  get '/new' => 'post#new'

  post '/create' => 'post#create'
```

정보를 받는 쪽이 post.  new에서 create로 연결됨.



<a>a 태그도 보안 설정 해줘야함.

```html
<a href="/post/destroy/<%=post.id%>" data-confirm="sure?" data-method="delete">Delete</a>
```

<a> a태그로 삭제 작업 진행하는데 보안 안해주면 url로  접근해서 data를 삭제 할 수 있음. 그래서 data-method="delete"처리해줘야함.

그리고 routes.rb에서도 get을 delete로 바꿔줘야함

```html
  delete '/comdel/:id' => 'post#comdel'
```



confirm은 삭제할 때 확인 하는거.





## Comment 달기

---

#### db생성

comment도 저장해서 관리해야하니깐 db만들어줌

```cmd
$rails g model comment
```

그리고 db-migrate에 가서 rb파일에 추가

```ruby
t.string :name
t.text :comm
t.integer :post_list_id 
```

작성자 이름, 댓글, 그리고 어느 글에 달렸는지 저장해야하니깐 글 id까지.

post_list는 내가 만든 글 db이름. 만약 내가 p로 db이름을 했으면 p_id

```cmd
$rake db:migrate
```

db 테이블 생성



#### db연결

그리고 두개를 연결 시켜줘야함

```ruby
#app-models-post_list.rb
has_many :comments
```

이거는 약속 comments. 무조건 복수형으로 해야함. 만약 db가 com이면coms로

```ruby
#app-models-comment.rb
belongs_to :post
```

이거는 무조건 단수.

이렇게 설정해줘야 서로 접근해서 쓸 수 있음.



#### 댓글 보여주기

```html
  <h4>Comment</h4>
  <hr />
  <%@p.comments.reverse.each do |com|%>
  <h5>
  작성자: <%=com.name%>
  내용: <%=com.comm%>
  시간: <%=com.created_at%>
  </h5>
  <a href="/comedit/<%=com.id%>">수정</a>
  <a href="/comdel/<%=com.id%>" data-method="delete"
  data-confirm="delete?">삭제</a>
  <br /><br />
  <%end%>
```

보면내가 @p로 post를 받아왔는데 post에 딸린 comments를 가져올 수 있음. 



#### 댓글 추가

```html
<form action="/add_comment" method="post">
    <div class="form-group" ><h3>
        작성자: </h3> <input type="text" name="name" style="width: 600px;" class="form-control" size="7">
        <h2> 댓글: </h2> <input   style="width: 300px;" type="text" name="text" class="form-control">
    </div>
    <input type="hidden" name="id" value="<%=@p.id%>" />
    <input type="hidden" name="authenticity_token"  value="<%= form_authenticity_token %>"/><br />
    <input  type="submit"/>
  </form>
```

댓글 작성 하고 넘길 때 어느 글에 속한 댓글인지 구분하기 위해 글의 id를 hidden 타입으로 넘겨줌. 

```ruby
def add_comment
    Comment.create(name: params[:name], comm: params[:text], post_list_id: params[:id] )
    redirect_to :back
  end
```

컨트롤러에서 넘긴 post_list_id(@p.id)를 같이 저장해줌 

redirect_to :back은 바로 전 페이지로 돌아감



#### 댓글 삭제

이건 삭제 할 때

```ruby
  def comdel
    comment = Comment.find(params[:id])
    post = comment.post_list_id
    comment.destroy
    redirect_to "/show/#{post}"
  end
```

comment의 post_list_id를 가져와서 다시 그 글로 돌아감