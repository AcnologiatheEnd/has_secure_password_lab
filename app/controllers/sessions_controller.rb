class SessionsController < ApplicationController
  def new
    @user = User.new
    flash[:error] = nil
  end
  
  def create
    @user = User.find_by(name: params[:user][:name])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to 'welcome/home'
    else
      flash[:error] = "yea error mate"
      render 'new'
    end
  end

  def destroy
    session.delete :user_id
    redirect_to '/'
  end
  
  private 
    def session_params
      params.require(:session).permit(:name, :password)
    end
end
