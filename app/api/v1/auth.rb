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
          APIKey.create(access_token: SecureRandom.hex, user: user)
        end
      end

      desc 'Facebook Login'
      params do
        requires :email, type: String
        requires :access_token, type: String
        optional :name, type: String
      end
      post 'facebook' do
        user = User.find_by(email: params[:email].downcase)
        unless user
          user = User.create(name: params[:name],
                             email: params[:email],
                             password: 'facebook',
                             password_confirmation: 'facebook',
                             account_type: 1)
          UserMailer.welcome_email(user)
        end
        APIKey.create(access_token: params[:access_token], user: user)
      end
    end
  end
end
