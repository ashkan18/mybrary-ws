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
				requires :location, type: Hash, documentation: { example: 'Location object with lat and lon' } do 
					requires :lat, type: BigDecimal, documentation: { example: 'Current Latitude of the book' }
					requires :lon, type: BigDecimal, documentation: { example: 'Current Longitude of the book' }
				end
			end
			post '/' do 
				BookInstance.create(location: [params[:location][:lat].to_f, params[:location][:lon].to_f], 
													  book: Book.find_or_create_by(isbn: params[:isbn]),
														user: @current_user)
			end
		end
	end
end