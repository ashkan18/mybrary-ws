require 'V1/books'
require 'V1/book_instances'
require 'V1/users'
require 'V1/auth'
require 'V1/defaults'

class Uook < Grape::API
	
	prefix "api"
	
	before do
		header['Access-Control-Allow-Origin'] = '*'
  	header['Access-Control-Request-Method'] = '*'
	end
	    
	mount V1::Books
	mount V1::BookInstances
	mount V1::Users
  mount V1::Auth

	add_swagger_documentation :format => :json,
                        		:mount_path => "/swagger_doc",
                        		:hide_documentation_path => true	

end 
