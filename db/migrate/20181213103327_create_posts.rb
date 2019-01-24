class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :text
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
