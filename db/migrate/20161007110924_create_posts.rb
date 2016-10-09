class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.string  :title, limit: 100, uniq: true
      t.string  :slug, uniq: true
      t.text    :body

      t.timestamps
    end
  end
end
