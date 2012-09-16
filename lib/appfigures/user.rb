require 'httparty'
require 'uri'

module Appfigures
  class User
    include HTTParty
    base_uri API_URL
    format :json
    
    def initialize(username, password)
      @auth = {:username => username, :password => password}
    end

    def details(email=@auth[:username])
      email = URI.escape(email)
      self.class.get("/users/#{email}", {:basic_auth => @auth})
    end
    
    def products(email=@auth[:username])
      email = URI.escape(email)
      self.class.get("/users/#{email}/products", {:basic_auth => @auth})
    end
  end
end