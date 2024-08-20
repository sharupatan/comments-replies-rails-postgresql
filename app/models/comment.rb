class Comment < ApplicationRecord
    belongs_to :user

    # Initialize replies as an empty array if it's nil
  before_save :initialize_replies

  def add_reply(reply_content, user_id)
    id = UUID.new.generate
    self.replies[id] = {name: reply_content, user_id: user_id}
    save
  end

  def increment_likes
    self.likes_count += 1
    save
  end

  private

  def initialize_replies
    self.replies ||= {}
  end
end
