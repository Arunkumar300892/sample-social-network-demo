class DashboardController < ApplicationController

  def index
    @users = User.all
    @posts = Post.all
    @comments_count = Comment.all.count
    @likes_count = Like.all.count
  end

end
