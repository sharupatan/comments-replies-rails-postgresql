class CommentsController < ApplicationController
    def index
        @comments = Comment.order(created_at: :desc)
        @new_comment = Comment.new
    end

    def create
        @comment = Comment.new(user_id: 1)
        if @comment.save
            redirect_to comments_path, notice: 'Comment was successfully created.'
        else
            @comments = Comment.includes(:user).all
            render :index
        end
    end

    def reply
        @comment = Comment.find(params[:id])
        @comment.add_reply(params[:reply_content], User.first.id)
        redirect_to comments_path
    end

    private

    def comment_params
        params.permit(:user_id)
    end
end
