class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
    	t.integer :user_id
    	t.string :name
    	t.string :description
    	t.string :imageURL
    	t.integer :borrowedTimes
      t.timestamps
    end
  end
end
