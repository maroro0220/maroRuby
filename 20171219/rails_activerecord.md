# rails_active record

---

```cmd
$rails g model "이름"
$rake db:migrate 
```

이름에 post를 넣으면 post라는 db객체가 생성

models폴더 밑에 "이름".rb파일이 생김.

posts해도 post로 알아서 생김. 단수로. 그리고 안에 클래스를 우리가 활용

 

db-migrate아래생긴 루비 파일에서 

```ruby
#User 데이터베이스 migrate init
      t.string :mem_id
      t.string :mem_name
      t.string :mem_email
      t.string :mem_pwd
```

이렇게 테이블 속성? 초기화 하고

cmd에서 rake하면 테이블이 생김



```ruby
@posts = Post.all.reverse
Post.create(:username => params[:username],
      :title => params[:title], :text => params[:text])
  @post=Post.find(params[:id])
```

이런식으로 post.db에 접근 가능. 클래스가 Post로 설정되어있음.

```html
<p><a class="btn btn-danger" href="/post/destroy/<%=@post.id%>" role="button">삭제</a>
<a class="btn btn-success" href="/post/edit/<%=@post.id%>" role="button">수정</a>
<a class="btn btn-info" href="/post/index" role="button">홈</a></p>
```

혹은 다른 erb 파일에서도 접근 가능



```ruby
# routes.rb
  get 'post/edit/:id' => 'post#edit'
  get 'post/update/:id' => 'post#update'

#  get '/edit/:id' => 'post#edit'
#  get '/update/:id' => 'post#update'
```

각각의 db에 접근 할 때 id가 필요하기 때문에 이런식으로 route에서 연결시켜줌

주석처리한 부분처럼 써도 됨.

앞에 post 없어도 됨.  요청을 할 때 post없이 하면 되니깐. 

get 다음 부분이 요청 관련 부분. 해당 요청이 들어오면  => 여기로 보낸다.

---

##### gem

gem을 설치하려면

gemfile에 development에 추가하고

cmd 창에서 bundle install 후 서버 재시작

```ruby
group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'

  gem 'rails_db' #db는 실제 환경에서 내놓으면 안되기 떄문에 개발환경에서만 쓰는거
end
```

```cmd
$bundle install
```

 gem 'rails_db'를 developement에 넣는 이유는 db는 실제 환경에서 오픈되면 안되니깐. 개발 환경에서만 쓰는거라서 development에 넣음