class AddTitleAndLikesCountToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :title, :string
    add_column :comments, :likes_count, :integer, default: 0
  end
end
