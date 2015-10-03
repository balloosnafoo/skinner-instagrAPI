class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :tag, null: false
      t.integer :begin_time
      t.integer :end_time

      t.timestamps null: false
    end
  end
end
