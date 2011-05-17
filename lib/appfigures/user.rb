require 'httparty'

module Appfigures
  class User
    include HTTParty
    base_uri API_URL
    format :json
    
    def self.details(email)
      get("/users/#{email}")
    end
    
    def self.apps(email)
      get("/users/#{email}/apps")
    end
    
    def self.external(email)
      get("/users/#{email}/itc_accounts")      
    end
  end
end