class SessionsController < ApplicationController

  def new
    #if (@user= cookies.signed[:user_id] && [:id] != nil)#ログイン済みならログイン後のページを表示
      #redirect_to user_url(current_user),layout: false #application.html.erbを適用したくない
    #elsif#ログインページを表示
      render layout: false #application.html.erbを適用したくない
    #end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      remember user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in? #userがログイン中の時のみログアウトする
    redirect_to root_url
  end
end