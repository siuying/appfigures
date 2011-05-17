require 'httparty'

module Appfigures
  class Rank
    include HTTParty
    base_uri API_URL
    format :json
    
    def initialize(username, password)
      @auth = {:username => username, :password => password}
    end
    
    # Generating a Ranks Report
    def ranks(app_id, granularity, start_date, end_date, options = {})
      options.merge!({:basic_auth => @auth})
      self.class.get("/reports/ranks/#{app_id}/#{granularity}/#{start_date}/#{end_date}/", options)
    end
  end
end