class LoadData < ActiveRecord::Migration
  def up
    #Create user
    user = User.new(:email => "a", :username => "a")
    user.password = "a"
    user.save

  	#Create rooms
  	room = Room.new(:name => "Living Room", :description => "modern multi-colored living room", :imageURL => "/images/room01.jpg", :borrowedTimes => 5)
  	room.save

  	room = Room.new(:name => "Living Room 2", :description => "nothing is better than gazing at the sea in the morning", :imageURL => "/images/room02.jpg", :borrowedTimes => 4)
  	room.save

  	room = Room.new(:name => "Bedroom", :description => "simple white yet colorful bed", :imageURL => "/images/room03.jpg", :borrowedTimes => 3)
  	room.save

  	room = Room.new(:name => "Kitchen", :description => "check out my expensive dining room set", :imageURL => "/images/room04.jpg", :borrowedTimes => 2)
  	room.save

  	room = Room.new(:name => "Modern Bedroom", :description => "just as the name suggests", :imageURL => "/images/room05.jpg", :borrowedTimes => 4)
  	room.save

  	room = Room.new(:name => "Empty Living Room", :description => "nothing but a red couch", :imageURL => "/images/room06.jpg", :borrowedTimes => 1)
  	room.save
  end

  def down

  end
end
