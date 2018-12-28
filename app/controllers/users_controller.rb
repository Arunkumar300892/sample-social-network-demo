class UsersController < ApplicationController
  # callbacks
  before_action :authenticate_user!
  before_action :authorized?

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end
  
  protected

  def authorized?
    redirect_to user_path(current_user),
      alert: "Access Denied !" unless current_user.id == params[:id].to_i
  end

end
