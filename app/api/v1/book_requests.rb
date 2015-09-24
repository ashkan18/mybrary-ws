module V1
  class BookRequests < Grape::API
    include V1::Defaults
    before do
      authenticate!
    end

    resources :book_requests do
      desc 'Create new book request'
      params do
        requires :book_instance_id, type: Integer
        requires :req_type, type: Integer, values: [Constants::OfferTypes::FREE,
                                                    Constants::OfferTypes::RENT,
                                                    Constants::OfferTypes::SELL], default: Constants::OfferTypes::FREE
        optional :status, type: Integer, default: Constants::TransStatuses::REQUESTED
      end
      post '' do
        book_instance = BookInstance.find(params[:book_instance_id])

        br = BookRequest.create(book_instance: book_instance,
                           user: @current_user,
                           status: params[:status],
                           trans_type: params[:trans_type])
        BookRequestMailer.book_inquery_email(br).deliver_now
        present br
      end

      route_param :id do
        get do
          BookRequest.find(params[:id])
        end

        params do
          requires :status, type: Integer,
                            values: [Constants::TransStatuses::REQUESTED,
                                     Constants::TransStatuses::DONE,
                                     Constants::TransStatuses::REJECTED],
                            default: Constants::TransStatuses::REQUESTED
        end
        put do
          br = BookRequest.find(params[:id])
          br.update(status: params[:status])
          BookRequestMailer.request_accept_email(br).deliver_now if params[:status] == Constants::TransStatuses::DONE
          present br
        end
      end
    end
  end
end
