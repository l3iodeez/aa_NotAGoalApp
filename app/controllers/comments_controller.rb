class CommentsController < ApplicationController

  def create
    @comment = current_user.authored_comments.new(comment_params)

    if @comment.save
      back_to_comment_form
    else
      flash[:errors] = @comment.errors.full_messages
      back_to_comment_form
    end
  end


  private

    def comment_params
      params.require(:comment).permit(:body, :commentable_id, :commentable_type)
    end

    def back_to_comment_form
      if comment_params[:commentable_type] == "User"
        redirect_to user_url(comment_params[:commentable_id])
      elsif comment_params[:commentable_type] == "Goal"
        redirect_to goal_url(comment_params[:commentable_id])
      else
        flash[:errors] = "what did you do"
        redirect_to user_url(current_user), status: :unprocessable_entity
      end
    end

end
