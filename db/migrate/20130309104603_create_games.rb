class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :status
      t.string :secret_key
      t.integer :user_id
      t.string :message
      t.timestamps
    end
    add_index :games, :user_id
  end
end
