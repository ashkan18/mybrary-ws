class BookRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :book_instance
end
