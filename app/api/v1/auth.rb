require 'securerandom'

module V1
  class Auth < Grape::API
    include V1::Defaults
    resources :auth do
      desc 'Login'
      params do
        requires :email, type: String
        requires :password, type: String
      end
      post '' do
        user = User.find_by(email: params[:email].downcase)
        if user && user.authenticate(params[:password])
          APIKey.create(access_token: SecureRandom.hex, user: user)	end
      end
    end
  end
end
