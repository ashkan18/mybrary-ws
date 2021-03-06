class BookInstance < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  acts_as_mappable lat_column_name: :lat,
                   lng_column_name: :lon

  default_scope { where.not(status: Constants::BookInstanceStatus::DELETED) }
end
