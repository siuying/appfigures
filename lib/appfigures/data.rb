require 'httparty'

module Appfigures
  class Data
    include HTTParty
    base_uri API_URL
    format :json
    
    def self.categories
      get("/data/categories")
    end
    
    def self.stores
      get("/data/stores")
    end
    
    def self.languages
      get("/data/languages")
    end
    
    def self.currencies
      get("/data/currencies")
    end

  end
end