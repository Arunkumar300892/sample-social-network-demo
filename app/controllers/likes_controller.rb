class LikesController < ApplicationController
    before_action :find_post
    before_action :find_like, only: [:destroy]

    def create
      if already_liked?
        flash[:notice] = "You can't like more than once"
      else
        @post.likes.create(user_id: current_user.id)
        @post.update_attribute(:likes_count, @post.likes_count + 1)
      end
      redirect_to posts_path
    end

    def destroy
      if !(already_liked?)
        flash[:notice] = "Cannot unlike"
      else
        @like.destroy
        @post.update_attribute(:likes_count, @post.likes_count - 1) if @post.likes_count > 0
      end
      redirect_to posts_path
    end

    private

    def find_post
     @post = Post.find(params[:post_id])
    end

    def already_liked?
      Like.where(user_id: current_user.id, post_id:
      params[:post_id]).exists?
    end

    def find_like
      @like = @post.likes.find(params[:id])
    end
end