class CommentsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "comments_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_comment(data)
    comment = Comment.create(title: data['title'], user_id: data['user_id'])
    ActionCable.server.broadcast("comments_channel", {comment: comment})
  end

  def send_reply(data)
    comment = Comment.find(data['comment_id'])
    comment.add_reply(data['title'], data['user_id'])
    ActionCable.server.broadcast("comments_channel", {comment: comment})
  end
end
