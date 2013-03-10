class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :oauth_token
      t.integer :game_id
      t.string :status
      t.datetime :oauth_expires_at
      t.timestamps
    end
    add_index :users, :game_id
  end
end
