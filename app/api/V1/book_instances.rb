require 'defaults'

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
				requires :give_type, type: Integer, values: [Constants::GiveTypes::FREE, 
																										 Constants::GiveTypes::RENT,
																										 Constants::GiveTypes::SELL], default: Constants::GiveTypes::FREE
				requires :location, type: Hash, documentation: { example: 'Location object with lat and lon' } do 
					requires :lat, type: BigDecimal, documentation: { example: 'Current Latitude of the book' }
					requires :lon, type: BigDecimal, documentation: { example: 'Current Longitude of the book' }
				end
			end
			post '/' do 
				book_instance = BookInstance.find_or_create_by(book: Book.find_or_create_by(isbn: params[:isbn]),
																											 user: @current_user) 
				book_instance.lat = params[:location][:lat].to_f
				book_instance.lon = params[:location][:lon].to_f
				book_instance.offer_type = params[:give_type]
				book_instance.save
				book_instance
			end
		end
	end
end