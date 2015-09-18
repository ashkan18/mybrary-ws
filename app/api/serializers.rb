require 'roar/json'

module Serializers
  module UserRepresenter
    include Roar::JSON
    include Grape::Roar::Representer

    property :name
  end

  module BookInstanceRepresenter
    include Roar::JSON
    include Grape::Roar::Representer

    property :lat
    property :lon
    property :id
    property :user_id
  end

  module BookRepresenter
    include Roar::JSON
    include Grape::Roar::Representer

    property :name
    property :isbn
    collection :book_instances, extend: BookInstanceRepresenter
  end

  module BooksRepresenter
    include Roar::JSON
    include Grape::Roar::Representer

    collection :entries, extend: BookRepresenter, as: :books, embedded: true
  end

  module BookInstanceFullRepresenter
    include Roar::JSON
    include Grape::Roar::Representer

    property :lat
    property :lon
    property :id
    property :user, extend: UserRepresenter
    property :book
  end


  module BookRequestRepresenter
    include Roar::JSON
    include Grape::Roar::Representer

    property :id
    property :user, extend: UserRepresenter
    property :book_instance, extend: BookInstanceFullRepresenter
  end

  module BookRequestsRepresenter
    include Roar::JSON
    include Grape::Roar::Representer

    collection :entries, extend: BookRequestRepresenter, as: :requests, embedded: true
  end
end