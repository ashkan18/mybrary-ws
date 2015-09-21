module V1
  class BookInstances < Grape::API
    include V1::Defaults
    before do
      authenticate!
    end
    resources :book_instances do
      desc 'Create new book instance'
      params do
        requires :isbn, type: String, documentation: { example: 'ISBN of the book' }
        requires :offer_type, type: Integer, values: [Constants::OfferTypes::FREE,
                                                      Constants::OfferTypes::RENT,
                                                      Constants::OfferTypes::SELL], default: Constants::OfferTypes::FREE
        requires :location, type: Hash, documentation: { example: 'Location object with lat and lon' } do
          requires :lat, type: BigDecimal, documentation: { example: 'Current Latitude of the book' }
          requires :lon, type: BigDecimal, documentation: { example: 'Current Longitude of the book' }
        end
      end
      post '/' do
        book_instance = BookInstance.find_or_create_by(book: Book.find_or_create_by(isbn: params[:isbn]),
                                                       user: @current_user)
        book_instance.update(lat: params[:location][:lat].to_f,
                             lon: params[:location][:lon].to_f,
                             offer_type: params[:offer_type])
        book_instance
      end

      route_param :id do
        get do
          present BookInstance.includes(:user).find(params[:id]), with: Serializers::BookInstanceRepresenter
        end
      end
    end
  end
end
