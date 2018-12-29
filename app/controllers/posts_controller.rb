class PostsController < ApplicationController
    before_action :signed_in?
    before_action :post_owner?, only: :destroy

    helper ApplicationHelper
    
    def create
      @post = current_user.posts.new(post_params)
      if @post.save
        flash[:notice] = "Post created successfully!"
      else
        flash[:error] = "Something went wrong!"
      end
      redirect_to root_url
    end

    def index
      @post  = current_user.posts.build
      @posts = Post.all.includes(:user, :likes, :comments)
    end

    def show
      @post = Post.find(params[:id])
    end

    def destroy
      @post.destroy
      flash[:notice] = "Post deleted successfully!"
      redirect_to request.referrer || root_url  
    end

    private

    def post_params
      params.require(:post).permit(:content, :avatar)
    end

    def post_owner?
      @post = Post.find_by(id: params[:id])
      redirect_to root_url unless @post or current_user.admin?
    end
end
