class User < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :email, :password_digest, :username
  has_many :rooms
  has_many :items

  validates :email, :password_digest, :username, :presence => true


  def password=(fullPassword)
		hashed = Digest::SHA1.hexdigest(fullPassword)
		self.password_digest = hashed
	end

	def password_valid?(candidate)
		hashed = Digest::SHA1.hexdigest(candidate)
		return hashed == self.password_digest
	end
end
