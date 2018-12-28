class CommentsController < ApplicationController
    before_action :get_commentable, only: [:new, :create]
    before_action :allowed?, only: [:destroy]

    def new
      @comment = Comment.new
    end

    def create
      @comment = @commentable.comments.new comment_params
      @comment.user_id = current_user.id
      if @comment.save
        @commentable.update_attribute(:comments_count, @commentable.comments_count + 1)
        redirect_to posts_path, notice: 'Comment posted successfully!'
      else
        redirect_to posts_path, notice: "Something Went wrong. Please try agian later!"
      end
    end

    def destroy
      commentable = @comment.commentable
      commentable.update_attribute(:comments_count, commentable.comments_count - 1)
      @comment.destroy
      flash[:notice] = "Comment deleted successfully!"
      redirect_to root_url
    end

    private

    def comment_params
      params.require(:comment).permit(:content)
    end

    def get_commentable
      @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
      @commentable = Post.find_by_id(params[:post_id]) if params[:post_id]
    end

    def allowed?
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url unless @comment or current_user.admin?
    end
end
