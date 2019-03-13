class UsersController < ApplicationController
  before_action :correct_user,   only: [:edit, :update]

  def show
    if (@user= cookies.signed[:user_id])#ログイン済みならログイン後のページを表示
    @user = User.find(params[:id])
    end
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    
    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(home_url) unless @user == current_user# 仮　正しいユーザー出ないときはフォローボタンが表示されるようにしたい
    end
end