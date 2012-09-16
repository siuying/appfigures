require 'httparty'

module Appfigures
  class External
    include HTTParty
    base_uri API_URL
    format :json

    def initialize(username, password)
      @auth = {:username => username, :password => password}
    end

    def external
      self.class.get("/external_accounts", {:basic_auth => @auth})      
    end
  end
end