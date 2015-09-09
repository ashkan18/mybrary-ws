class Book < ActiveRecord::Base
  belongs_to :author
  has_many :book_instances
  has_many :users, through: :book_instances 
end
