class Item < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  belongs_to :room
  has_and_belongs_to_many :tags
end
