module V1
	class Users < Grape::API
		include V1::Defaults

		resources :users do
			desc 'Add a new user'
			params do
				requires :name, type: String
				requires :type, type: Integer
				requires :password, type: String
				requires :email, type: String
			end
			post '' do
				user = User.find_by(email: params[:email])
				unless user
					user = User.new(name: params[:name], 
													email: params[:email],
                 					password: params[:password], 
                 					password_confirmation: params[:password])
					user.save
        end
				user 
			end
		end
	end
end