class CommentsController < ApplicationController
    def index
        @comments = Comment.order(created_at: :desc)
        @new_comment = Comment.new
    end

    def create
        # here the user_id should be taken from the current user
        @comment = Comment.new(comment_params)
        if @comment.save
            # Instead of redirecting, you can broadcast the comment here if needed
            ActionCable.server.broadcast("comments_channel", {comment: @comment})
            head :ok # Respond with HTTP 200 OK
        else
            render :index
        end
    end

    def reply
        @comment = Comment.find(params[:id])
        # here the user_id should be taken from the current user
        @comment.add_reply(params[:reply_content], User.first.id)
        redirect_to comments_path
    end

    private

    def comment_params
        params.require(:comment).permit(:user_id, :title)
    end
end
