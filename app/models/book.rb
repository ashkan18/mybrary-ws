class Book < ActiveRecord::Base
  belongs_to :author
  has_many :book_instances
  has_many :book_genres
  has_many :users, through: :book_instances
  has_many :genres, through: :book_genres
  acts_as_mappable through: :book_instances
end
