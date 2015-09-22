module V1
  class Genres < Grape::API
    include V1::Defaults

    resource :genres do
      get do
        Genre.all
      end

      route_param :genre_id do
        get do
          Genre.find(id: params[:genre_id])
        end

        get '/books' do
          present Book.joins([:book_genres, :book_instances]).includes(:book_instances).where(book_genres: {genre: params[:genre_id]}), with: Serializers::BooksRepresenter
        end
      end
    end
  end
end
