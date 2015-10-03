class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :link, null: false
      t.string :image_url, null: false
      t.string :caption
      t.string :username, null: false
      t.string :media_type, null: false
      t.integer :collection_id, null: false
      t.integer :tag_time, null: false

      t.timestamps null: false
    end
  end
end
