class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :encrypted_password
      t.integer :comments_count
      t.integer :likes_count
      t.boolean :private, default: false

      t.datetime :remember_created_at
      t.datetime :reset_password_sent_at
      t.string :reset_password_token

      t.timestamps
    end
  end
end
