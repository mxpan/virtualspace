class User < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :rooms
  has_many :items
end
