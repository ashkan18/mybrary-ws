module V1
	module Defaults
  	extend ActiveSupport::Concern
	  included do
	    prefix "api"
	    version "v1", using: :header, vendor: 'Ashkan'
	    format :json
	    formatter :json, Grape::Formatter::Roar
	    content_type :json, 'application/json'
	    rescue_from ActiveRecord::RecordNotFound do |e|
        error!(e.message, 404)
      end

		  helpers do
		    def logger
		      Rails.logger
		    end
		    def authenticate!
		    	error!('Unauthorized. Invalid or expired token.', 401) unless current_user
    		end

		    def current_user
		      # find token. Check if valid.
		      error!('Missing auth token') unless headers.has_key?('X-Authtoken')
		      token = APIKey.find_by(access_token: headers['X-Authtoken'])
		      if token
		        @current_user = User.find(token.user_id)
		      else
		        false
		      end
		    end

		  end
		end
  end
end