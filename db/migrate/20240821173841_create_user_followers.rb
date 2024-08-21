class CreateUserFollowers < ActiveRecord::Migration[6.1]
  def change
    create_table :user_followers do |t|
      t.integer :followers_id
      t.integer :following_id

      t.timestamps
    end

    add_index :user_followers, :followers_id
    add_index :user_followers, :following_id
  end
end
