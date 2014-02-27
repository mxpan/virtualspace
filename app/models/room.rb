class Room < ActiveRecord::Base
  attr_accessible :name, :description, :imageURL, :borrowedTimes, :user_id
  has_many :items
  has_and_belongs_to_many :tags
  belongs_to :user

  mount_uploader :imageURL, ImageUploadUploader
end
