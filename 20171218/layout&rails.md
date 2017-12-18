# Layout

---



마스터 슬라이드 같은거

기본 베이스로 깔림.

페이지가 이동해도 계속 유지되는 설정. ex) 메뉴 바



sinatra에서 views에 layout.erb가 있으면 layout.erb부터 실행.

```erb
<!--layout.erb-->
<body>
      <nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="/">대나무 숲</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarNav">
    <ul class="navbar-nav">
      <li class="nav-item active">
        <a class="nav-link" href="/">Home <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/new">board</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/signup">signup</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/users">user list</a>
      </li>
    </ul>
  </div>
</nav>

<%=yield%>

</body>
</html>

```

이렇게 하면 위에 <nav>(메뉴 바)는 계속 유지됨.

yield는 함수 호출과 함께 요청 받은 값 처리하는 부분

그래서 만약 posts.erb를 요청 받으면

layout.erb 먼저 들어가서 처리하다가 yield에서 요청 받은 erb파일을 처리.

---



# Rails

드디어 레.일.즈!

#### rails 설치 코드

```
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
```

```
gem install rails -v 4.2.9
rbenv rehash
rails -v
# Rails 4.2.9
```

버전 확인 (-v)까지 완료되면 

rails new "프로그램명(영어로)"

완료되면



#### 서버시작

"프로그램명" 폴더로 들어가서

```cmd
프로그램명$ rails s -b 0.0.0.0
```

하면 서버 시작.

확인방법은 chrome에 localhost:3000



#### controller생성

```cmd
$rails generate controller home index
```

이렇게 치면 

app-controllers-home_controller.rb

app-views-home-index.html-erb

생성 됨

home 대신 ho하면 ho_controller.rb

그리고 

home a b c d

하면 index말고 a b c d .erb만들어짐

그리고 config-routes.rb에 

get으로 루트들 추가됨

generate대신 g써도 됨



#### routes

routes.rb는 연결 시켜주는거

```ruby
get '/index' => 'home#index'
```

/index요청이 들어오면 views-home-index.erb로 연결

가기 전에 자동으로

app - controllers - home_controllers.rb 실행

erb :은 생략 알아서 넘겨줌 

sinatra 연습 할 떄 app.rb가 routes.rb랑 controller.rb로 나눠진거



##### hash & sample

아래는  sample이랑 hash 활용.

```ruby
#home_controller.rb

@n=(1..9).to_a.sample(3)
    n2=(1..5).to_a.sample
    @make={1 => "덕력", 2 => "노안", 3 => "인기", 4 => "집중력", 5 => "뭔지 모르겠는데", 6 => "자상함", 7 => "허세", 8 => "똘끼", 9 => "귀찮음"}
    @make2={1 => "아주 조금", 2 => "조금", 3 => "보통",4 => "많이", 5 =>"아아아아아주 많이"}[n2]

```

@n은 @make의 key 값을 sample 3개 추출. @n과 @make 따로따로 전달

n2는 sample 1개 추출해서  hash의 key 값으로 바로 넣어서 value를 @make2에 넣어서 전달



```ruby
#resultrand.html.erb
<h1> <%=@name%>을 만들 때  <%=@make[@n[0]]%> + <%=@make[@n[1]]%> + <%=@make[@n[2]]%>를 <%=@make2%> 넣음</h1>

```

@make2는 controller에서 이미 key에 해당되는 value를 전달 받은거기 때문에 바로 출력

@make는 hash로 넘겨 받았기 때문에 key값이 될 @n도 넘겨 받아서 출력



##### 검색 연결

```html
<form action="https://www.google.co.kr/search?">
  <p><h2>검색:
  <input type="text" name="q" />
  <input type="submit" value="submit" /></h2></p>
</form>
```

사이트 마다 방식이 조금씩 다름 위에는 google

search?까지 긁어오고 text의 name을 '꼭'!!! q로 해주면 html에서 알아서 search? 뒤에 q를 붙임



아래는 naver.  name을 꼭 query로 

```html
<form action="https://search.naver.com/search.naver">
  <input type="text" name="query" />
  <input type="submit" />
</form>

```



---

