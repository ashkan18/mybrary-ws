module V1
  class BookTransactions < Grape::API
    include V1::Defaults
    # before do
    #   authenticate!
    # end
    
    resources :book_transacitons do
      desc 'Create new transaction'
      params do
        requires :book_instance_id, type: Integer
        requires :user_id, type: Integer 
        requires :trans_type, type: Integer, values: [Constants::OfferTypes::FREE, 
                                                      Constants::OfferTypes::RENT,
                                                      Constants::OfferTypes::SELL], default: Constants::OfferTypes::FREE
        requires :trans_value, type: Float
        requires :status, type: Integer, default: Constants::TransStatuses::REQUESTED
      end
      post '' do
        BookTransaction.create(book_instance: BookInstance.find_by(id: params[:book_instance_id]),
                                user: User.find_by(id: params[:user_id]),
                                status: params[:status],
                                trans_type: params[:trans_type],
                                trans_value: params[:trans_value])
      end
      
      route_param :id do
        get do
          BookTransaction.find(params[:id])
        end

        params do
          requires :status, type: Integer, 
                    values: [Constants::TransStatuses::REQUESTED, Constants::TransStatuses::DONE],
                    default: Constants::TransStatuses::REQUESTED
        end
        put do
          BookTransaction.find(params[:id]).update(status: params[:status])
        end
      end
    end
  end
end