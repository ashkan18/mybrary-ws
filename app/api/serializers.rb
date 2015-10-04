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

  module GenreRepresenter
    include Roar::JSON
    include Grape::Roar::Representer

    property :name
  end

  module AuthorRepresenter
    include Roar::JSON
    include Grape::Roar::Representer

    property :name
  end

  module BookRepresenter
    include Roar::JSON
    include Grape::Roar::Representer

    property :name
    property :isbn
    property :small_cover_url
    property :medium_cover_url
    property :large_cover_url
    property :author, extend: AuthorRepresenter
    collection :book_instances, extend: BookInstanceRepresenter
    collection :genres, extend: GenreRepresenter
  end

  module BookRepresenterWithoutInstances
    include Roar::JSON
    include Grape::Roar::Representer

    property :name
    property :isbn
    property :small_cover_url
    property :medium_cover_url
    property :large_cover_url
    property :author, extend: AuthorRepresenter
    collection :genres, extend: GenreRepresenter
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
    property :offer_type
    property :user, extend: UserRepresenter
    property :book, extend: BookRepresenterWithoutInstances
  end

  module BookInstancesRepresenter
    include Roar::JSON
    include Grape::Roar::Representer

    collection :entries, extend: BookInstanceFullRepresenter, as: :book_instances, embedded: true
  end

  module BookRequestRepresenter
    include Roar::JSON
    include Grape::Roar::Representer

    property :id
    property :status
    property :user, extend: UserRepresenter
    property :book_instance, extend: BookInstanceFullRepresenter
  end

  module BookRequestsRepresenter
    include Roar::JSON
    include Grape::Roar::Representer

    collection :entries, extend: BookRequestRepresenter, as: :requests, embedded: true
  end
end
