require 'httparty'

module Appfigures
  class Data
    include HTTParty
    base_uri API_URL
    format :json
    
    def initialize(username, password)
      @auth = {:username => username, :password => password}
    end
    
    def categories
      self.class.get("/data/categories", {:basic_auth => @auth})
    end
    
    def stores
      self.class.get("/data/stores", {:basic_auth => @auth})
    end
    
    def languages
      self.class.get("/data/languages", {:basic_auth => @auth})
    end
    
    def currencies
      self.class.get("/data/currencies", {:basic_auth => @auth})
    end

  end
end