

##### application_controller

app-controllers-application_controller

```ruby
  protect_from_forgery with: :exception

  #application_controller에서 작성한 메소드는 모든 컨트롤러에서 쓸 수 있다.
  def current_user
    # session.clear
    #logout 상태에서 db drop해야함 안그러면 session이 남아 있는 상태이기 때문에 db를 다시 켜도 session을 못찾아서 에러가 남. 그럴 땐 session.clear해주고 하면 됨. 현재 로그인이 되어 있지 않다면, session[:user_id] 값이 없을테니깐 nil
    if session[:user_id].nil?
      @user=nil
    else
      #현재 로그인이 되어 있으니까
      #세션에 id값이  있으니까 찾아서 넣는다.
      @user=User.find(session[:user_id])
    end
  end
  #우리가 도움을 줄 수 있는 메소드들을 미리 만들어 놓으면 그걸 동작하게 하는 애
  #view에서 확인하려면 controller통해서 해야하는데 그럴필요 없게 함.

  #view에서 보여주기 위해서는 컨트롤러에서 뷰로 넘겨야하는데
  #helper_method를 활용하여 바로 view에서 쓸 수 있도록 할 수 있다.
  helper_method :current_user
  def authorize
    redirect_to '/user/login' if current_user.nil?
  end
```

여기서 정의한 메소드는 모든 컨트롤러에서 쓸 수 있음

```ruby
#postcontroller
def edit
    @post=PostList.find(params[:id])
  if @post.user_id==current_user.id
  else
    redirect_to '/'
    end
  end
```

이런 식으로 current_user를 가져올 수도 있음



session은 전역변수 같은 느낌. clear해주지 않는 이상 계속 살아있음.

```ruby
  def logout
    session.clear
    flash[:alert]="Logout Successsssssssssssss"
    redirect_to '/'
  end
```

logout하면 session.clear로 session 종료

flash는 한번만 뜨는거. 같은 화면에서 새로고침 누르면 사라짐





```ruby
def login_process
    #1. mail주소가 우리 db없으면,(가입한 적이 없으면)
    #1-1. 없는 아이디 -> 회원가입
    user=User.find_by(email: params[:email])
    @msg=""
    if user.nil?
      # @msg="noononomember"
      flash[:alert] = "등록되지 않은 회원입니다. 등록해주세요."
      redirect_to '/user/new'
    #2. mail주소가 db에 있으면,
    #2-1 비밀번호 확인. 맞음 로그인인
    #2-2 틀리면, 비밀번호가 틀렸습니다.
  else
    if user.password == params[:password]
        # @msg="login Success"
        flash[:notice]="#{user.name} Login Success"
        session[:user_id]=user.id
        redirect_to '/'
    else
      flash[:alert]="password wrong"
      redirect_to :back
    end
  end
  end
```

login 요청이 들어오면 email확인 하고, email에 해당하는 user가 없으면 없다고 flash로 출력

```html
<!-- views-layouts-application.html.erb  -->

<%= render 'layouts/flash'%>
```

flash 출력은 이런식으로.