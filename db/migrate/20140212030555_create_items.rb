class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
    	t.string :name
    	t.string :description
    	t.string :imageURL
    	t.integer :borrowedTimes
      t.timestamps
    end
  end
end