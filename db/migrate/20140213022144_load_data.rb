class LoadData < ActiveRecord::Migration
  def up
    #Create user
    user = User.new(:email => "a", :username => "a")
    user.password = "a"
    user.save

  	#Create rooms
  	room = Room.new(:user_id => user.id, :name => "Living Room", :description => "modern multi-colored living room", :imageURL => "room01.jpg", :borrowedTimes => 5)
  	room.save

  	room = Room.new(:user_id => user.id, :name => "Living Room 2", :description => "nothing is better than gazing at the sea in the morning", :imageURL => "room02.jpg", :borrowedTimes => 4)
  	room.save

  	room = Room.new(:user_id => user.id, :name => "Bedroom", :description => "simple white yet colorful bed", :imageURL => "room03.jpg", :borrowedTimes => 3)
  	room.save

  	room = Room.new(:user_id => user.id, :name => "Kitchen", :description => "check out my expensive dining room set", :imageURL => "room04.jpg", :borrowedTimes => 2)
  	room.save

  	room = Room.new(:user_id => user.id, :name => "Modern Bedroom", :description => "just as the name suggests", :imageURL => "room05.jpg", :borrowedTimes => 4)
  	room.save

  	room = Room.new(:user_id => user.id, :name => "Empty Living Room", :description => "nothing but a red couch", :imageURL => "room06.jpg", :borrowedTimes => 1)
  	room.save

    
    tag = Tag.new(:name => "red")
    tag.save
    room.tags << tag

    item = Item.new(:user_id => user.id, :room_id => room, :name => "crib", :description => "new crib for my new crib", :imageURL => "item03.jpg", :borrowedTimes => 3)
    item.save

    tag = Tag.new(:name => "crib")
    tag.save
    item.tags << tag
  end

  def down

  end
end
