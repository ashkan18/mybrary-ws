module V1
	class Books < Grape::API
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
				all_or_none_of :lon, :lat
			end
			get '' do
				query = Book.all.joins(:book_instances)
				query = query.where("isbn" => params[:isbn]) if params.has_key?(:isbn)
				query = query.where("name" => params[:name]) if params.has_key?(:name)
				query = query.where("author.name" => params[:author_name]) if params.has_key?(:author_name)
				if params.has_key?(:lat) and params.has_key?(:lon)
					center = [params[:lat].to_f, params[:lon].to_f]
					query = query.within(5, origin: center)
				end
				present query, with: Serializers::BooksRepresenter
			end

			desc 'Get Specific book by isbn'
			get ':isbn' do
				Book.find_by(isbn: params[:isbn])
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
