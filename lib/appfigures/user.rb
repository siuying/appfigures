require 'httparty'

module Appfigures
  class User
    include HTTParty
    base_uri API_URL
    format :json
    
    def initialize(username, password)
      @auth = {:username => username, :password => password}
    end

    def details(email=nil)
      self.class.get("/users/#{email||@auth[:username]}", {:basic_auth => @auth})
    end
    
    def apps(email=nil)
      self.class.get("/users/#{email||@auth[:username]}/apps", {:basic_auth => @auth})
    end
    
    def external(email=nil)
      self.class.get("/users/#{email||@auth[:username]}/itc_accounts", {:basic_auth => @auth})      
    end
  end
end