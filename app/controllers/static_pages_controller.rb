class StaticPagesController < ApplicationController
  def home
    @user = current_user
    @micropost  = current_user.microposts.build
    @microposts = current_user.microposts.paginate(page: params[:page])
    @feed_items = current_user.feed.paginate(page: params[:page])
  end

  def help
  end

  def about
    @user = current_user
    @micropost  = current_user.microposts.build
    @microposts = current_user.microposts.paginate(page: params[:page])
    @feed_items = current_user.feed.paginate(page: params[:page])
  end
  
  def contact
  end
end
