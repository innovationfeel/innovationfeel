class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.string  :title, limit: 100, unique: true
      t.string  :slug, unique: true
      t.text    :body

      t.timestamps
    end

    add_index :posts, :slug, unique: true
  end
end
