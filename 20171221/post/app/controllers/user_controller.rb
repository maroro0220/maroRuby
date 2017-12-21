class UserController < ApplicationController
  def new
    #사용자에게 form 창을 보여주는 곳

  end
  def create
    #정보를 받아서 데이터베이스에서 만드는 c
    User.create(name: params[:name], email: params[:email], password: params[:password])
    @user=User.last
  end
  def index
    @users=User.all
  end
  def LOGIN
    #로그인을 위한 form

  end

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

  def logout
    session.clear
    flash[:alert]="Logout Successsssssssssssss"
    redirect_to '/'
  end

end
