class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #application_controller에서 작성한 메소드는 모든 컨트롤러에서 쓸 수 있다.
  def current_user
    # session.clear
    #logout 상태에서 db drop해야함 안그러면 session이 남아 있는 상태이기 때문에
    #db를 다시 켜도 session을 못찾아서 에러가 남.
    #그럴 땐 session.clear해주고 하면 됨
    #현재 로그인이 되어 있지 않다면,
    #session[:user_id] 값이 없을테니깐 nil
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
end
