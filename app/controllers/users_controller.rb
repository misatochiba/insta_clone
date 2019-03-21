class UsersController < ApplicationController
  before_action :correct_user,   only: [:edit, :update]
  before_action :logged_in_user, only: [:index,:destroy,:show,
                                        :following, :followers]
  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @micropost  = current_user.microposts.build
    @microposts = @user.microposts.paginate(page: params[:page])
    @feed_items = current_user.feed.paginate(page: params[:page])
  end

  def new
    @user = User.new
    render layout: false #application.html.erbを適用したくない
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "アカウント認証メールを送信しました。メールからログインしてください"
      redirect_to root_url  
    else #エラーメッセージが表示される場合
      render 'new',layout: false #application.html.erbを適用したくない
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
  
  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    redirect_to user_url(@user)
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    redirect_to user_url(@user)
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    
    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      #redirect_to(home_url) unless @user == current_user# 仮　正しいユーザー出ないときはフォローボタンが表示されるようにしたい
    end
end