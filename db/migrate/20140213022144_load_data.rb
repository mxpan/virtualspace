class LoadData < ActiveRecord::Migration
  def up
    #Create user
    user = User.new(:email => "mxpan@stanford.edu", :username => "Michelle")
    user.password = "michelle"
    user.first_login = 0
    user.save

    uploader = ImageUploadUploader.new

  	#Create rooms
  	room = Room.new(:user_id => user.id, :name => "Living Room", :description => "modern multi-colored living room", :borrowedTimes => 5)
    room.imageURL = File.open("#{Rails.root}/public/images/room01.jpg")
  	room.save

    tag = Tag.new(:name => "color")
    tag.save
    room.tags << tag

  	room = Room.new(:user_id => user.id, :name => "Second Living Room", :description => "nothing is better than gazing at the sea in the morning", :borrowedTimes => 4)
    room.imageURL = File.open("#{Rails.root}/public/images/room02.jpg")
  	room.save

    item = Item.new(:user_id => user.id, :room_id => room.id, :name => "French Table", :description => "UGLY French Table", :imageURL => File.open("#{Rails.root}/public/images/item01.jpg"), :borrowedTimes => 3)
    item.save

    tag = Tag.new(:name => "green")
    tag.save
    item.tags << tag

    tag = Tag.new(:name => "color")
    tag.save
    item.tags << tag

    user = User.new(:email => "mpick@stanford.edu", :username => "Matthew")
    user.password = "matthew"
    user.first_login = 0
    user.save

  	room = Room.new(:user_id => user.id, :name => "Bedroom", :description => "simple white yet colorful bed", :imageURL => File.open("#{Rails.root}/public/images/room03.jpg"), :borrowedTimes => 3)
  	room.save

    tag = Tag.new(:name => "white")
    tag.save
    room.tags << tag

    tag = Tag.new(:name => "bedroom")
    tag.save
    room.tags << tag

    item = Item.new(:user_id => user.id, :room_id => room.id, :name => "crib", :description => "new crib for my new crib", :imageURL => File.open("#{Rails.root}/public/images/item03.jpg"), :borrowedTimes => 3)
    item.save

    tag = Tag.new(:name => "crib")
    tag.save
    item.tags << tag

  	room = Room.new(:user_id => user.id, :name => "Kitchen", :description => "check out my expensive dining room set", :imageURL => File.open("#{Rails.root}/public/images/room04.jpg"), :borrowedTimes => 2)
  	room.save

  	room = Room.new(:user_id => user.id, :name => "Modern Bedroom", :description => "just as the name suggests", :imageURL => File.open("#{Rails.root}/public/images/room05.jpg"), :borrowedTimes => 4)
  	room.save

    user = User.new(:email => "topeo@stanford.edu", :username => "Tope")
    user.password = "tope"
    user.first_login = 0
    user.save

  	room = Room.new(:user_id => user.id, :name => "Empty Living Room", :description => "nothing but a red couch", :imageURL => File.open("#{Rails.root}/public/images/room06.jpg"), :borrowedTimes => 1)
  	room.save
 
    tag = Tag.new(:name => "red")
    tag.save
    room.tags << tag

    tag = Tag.new(:name => "living room")
    tag.save
    room.tags << tag

    tag = Tag.new(:name => "open")
    tag.save
    item.tags << tag

    user = User.new(:email => "test", :username => "Jon")
    user.password = "test"
    user.first_login = 0
    user.save

    room = Room.new(:user_id => user.id, :name => "Kitchen", :description => "mdoern kitchen courtesy of the good folks at Ikea", :imageURL => "room09.jpg", :borrowedTimes => 2)
    room.save

    tag = Tag.new(:name => "open")
    tag.save
    room.tags << tag

    tag = Tag.new(:name => "modern")
    tag.save
    room.tags << tag

    item = Item.new(:user_id => user.id, :room_id => room.id, :name => "Thomas the Tank Bed", :description => "gift from Mommy", :imageURL => "item02.jpg", :borrowedTimes => 3)
    item.save

    tag = Tag.new(:name => "classic")
    tag.save
    item.tags << tag

    tag = Tag.new(:name => "bed")
    tag.save
    item.tags << tag
  end

  def down

  end
end
