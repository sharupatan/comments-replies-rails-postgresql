class UserFollower < ApplicationRecord
    validates :followers_id, presence: true
    validates :following_id, presence: true
    validates :followers_id, uniqueness: { scope: :following_id }
    validate :prevent_self_following

    def prevent_self_following
        if followers_id == following_id
            errors.add(:following_id, "can't follow himself or herself")
        end
    end
end
