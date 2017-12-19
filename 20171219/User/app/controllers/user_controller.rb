class UserController < ApplicationController

  def index
    @user=Member.all.reverse
  end

  def new
  end

  def create
    ids=params[:ids]
    pwd1=params[:pwd1]
    pwd2=params[:pwd2]
    name=params[:name]
    email=params[:email]

    if pwd1==pwd2
      Member.create( mem_id: ids, mem_name: name,
        mem_email: email, mem_pwd: pwd1)
      redirect_to '/'
    else
      redirect_to '/new'
    end
  end

  def show
    @user=Member.find(params[:id])
  end

  def update
    user=Member.find(params[:id])
      ids=params[:ids]
      pwd1=params[:pwd1]
      pwd2=params[:pwd2]
      name=params[:name]
      email=params[:email]
      if pwd1==pwd2
        user.update(mem_id: ids, mem_name: name,
          mem_pwd: pwd1, mem_email: email)
          redirect_to '/'
      else
        redirect_to '/edit/#{params[:id]}'
      end
  end

  def edit
    @user=Member.find(params[:id])
  end

  def destroy
    user=Member.find(params[:id])
    user.destroy
  end
end
