class Item < ActiveRecord::Base
  attr_accessible :user_id, :room_id, :name, :description, :imageURL, :borrowedTimes
  belongs_to :user
  belongs_to :room
  has_and_belongs_to_many :tags
end
