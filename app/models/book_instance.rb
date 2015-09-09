class BookInstance < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  acts_as_mappable :default_units => :miles,
                   :default_formula => :sphere,
                   :lat_column_name => :lat,
                   :lng_column_name => :lon
end
