require 'httparty'

module Appfigures
  class User
    include HTTParty
    base_uri API_URL
    format :json
    
    def self.detail(email)
      get('/users/#{email}')
    end
    
    def self.apps(email)
      get('/users/#{email}/apps')
    end
  end
end