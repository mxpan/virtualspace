class CreateRoomsTags < ActiveRecord::Migration
  def change
    create_table :rooms_tags do |t|
      t.integer :room_id
      t.integer :tag_id
    end
  end
end
