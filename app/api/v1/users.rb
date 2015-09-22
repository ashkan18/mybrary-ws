module V1
  class Users < Grape::API
    include V1::Defaults

    resources :users do
      desc 'Add a new user'
      params do
        requires :name, type: String
        requires :account_type, type: Integer
        requires :password, type: String
        requires :email, type: String
      end
      post '' do
        user = User.find_by(email: params[:email])
        unless user
          user = User.new(name: params[:name],
                          email: params[:email],
                          password: params[:password],
                          password_confirmation: params[:password],
                          account_type: params[:account_type])
          user.save
        end
        user
      end
      route_param :user_id do
        desc 'get user by id'
        get do
          User.find(params[:user_id])
        end
      end

      namespace :me do
        before do
          authenticate!
        end
        get do
          @current_user
        end

        desc 'Get current user transactions'
        get 'requests' do
          present BookRequest.includes(:book_instance).where('user_id = ?', @current_user), with: Serializers::BookRequestsRepresenter
        end

        get 'inquiries' do
          present BookRequest.joins(:book_instance).includes(:book_instance).where('book_instances.user_id = ?', @current_user), with: Serializers::BookRequestsRepresenter
        end

        desc 'Get current user books'
        get 'book_instances' do
          present BookInstance.includes(:book).where(user: @current_user), with: Serializers::BookInstancesRepresenter
        end
      end
    end
  end
end
