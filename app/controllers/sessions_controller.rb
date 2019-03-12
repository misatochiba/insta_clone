class SessionsController < ApplicationController

  def new
    render layout: false #application.html.erbを適用したくない
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