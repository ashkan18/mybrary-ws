class User < ActiveRecord::Base
	
	validates :name, presence: true
	validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}

  has_many :book_instances
	has_many :books, through: :book_instances
  has_many :book_requests

	has_secure_password
end
