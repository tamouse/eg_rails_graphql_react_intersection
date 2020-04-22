class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :content
      t.boolean :published, null: false, default: false
      t.integer :author_id, null: false

      t.timestamps
    end

    add_foreign_key :posts, :users, column: :author_id
  end
end