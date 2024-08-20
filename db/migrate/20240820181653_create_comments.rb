class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.jsonb :replies, null: false, default: {}
      t.timestamps
    end
    add_index :comments, :replies, using: :gin
  end
end
