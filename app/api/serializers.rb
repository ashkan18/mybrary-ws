require 'roar/json'

module Serializers
  module BookInstanceRepresenter
    include Roar::JSON
    include Grape::Roar::Representer

    property :lat
    property :lon
  end

  module BookRepresenter
    include Roar::JSON
    include Grape::Roar::Representer

    property :name
    property :isbn
    collection :book_instances, extends: BookInstanceRepresenter
  end

  module BooksRepresenter
    include Roar::JSON
    include Grape::Roar::Representer

    collection :entries, extend: BookRepresenter, as: :books, embedded: true
  end
end