require 'rest-client'
require 'json'

module V1
	class Books < Grape::API
		ISBNDB_KEY = 'ZSXCUETS'

		include V1::Defaults
		
		before do
			authenticate!
		end

		resources :books do
			desc 'Search Books'
			params do
				optional :name, type: String
				optional :isbn, type: String
				optional :lat, type: BigDecimal
				optional :lon, type: BigDecimal
				optional :author_name, type: String
				optional :query, type: String
				all_or_none_of :lon, :lat
			end
			get '' do
				query = Book.all.joins(:book_instances)
				query = query.where("isbn" => params[:isbn]) if params.has_key?(:isbn)
				query = query.where("name" => params[:name]) if params.has_key?(:name)
				query = query.where("author.name" => params[:author_name]) if params.has_key?(:author_name)
				query = query.where("isbn ILIKE :query OR name ILIKE :query", query: "%#{params[:query]}%") if params.has_key?(:query)
				if params.has_key?(:lat) and params.has_key?(:lon)
					center = [params[:lat].to_f, params[:lon].to_f]
					query = query.within(5, origin: center)
				end
				present query, with: Serializers::BooksRepresenter
			end

			desc 'Get Specific book by isbn'
			get ':isbn' do
				unless Book.exists?(isbn: params[:isbn])
					isbn_db_response = RestClient.get "#{Rails.configuration.x.isbn_db_host}/#{Rails.configuration.x.isbn_db_api_key}/book/#{params[:isbn]}"
					if isbn_db_response.code == 200
						data = JSON.parse(isbn_db_response)
						present Book.create(isbn: params[:isbn], name: data['data'][0]['title']), with: Serializers::BookRepresenter
					end
				end 
				present Book.find_by(isbn: params[:isbn]), with: Serializers::BookRepresenter
			end

			desc 'Create a new Book'
			params do
				requires :isbn, type: String
				requires :name, type: String
			end
			post '' do
				present Book.find_or_create_by(isbn: params[:isbn], name: params[:name]), with: Serializers::BookRepresenter
			end
		end
	end
end
