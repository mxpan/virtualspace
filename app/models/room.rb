class Room < ActiveRecord::Base
  # attr_accessible :title, :body
  has_and_belongs_to_many :items
  has_and_belongs_to_many :tags
  belongs_to :user
end
