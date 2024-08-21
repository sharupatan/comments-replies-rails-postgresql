class AddUniqueIndexToUserFollowers < ActiveRecord::Migration[6.1]
  def change
    add_index :user_followers, [:followers_id, :following_id], unique: true
  end
end
