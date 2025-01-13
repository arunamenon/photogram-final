class CreatePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :photos do |t|
      t.text :caption
      t.integer :comments_count, default: 0
      t.integer :likes_count, default: 0
      t.integer :owner_id
      t.string :image

      t.timestamps
    end
  end
end
