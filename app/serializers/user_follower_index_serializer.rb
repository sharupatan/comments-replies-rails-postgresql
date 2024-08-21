class UserFollowerIndexSerializer < ActiveModel::Serializer
  attributes :id, :followers_id, :following_id
end
