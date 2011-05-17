require 'httparty'

module Appfigures
  class Rank
    include HTTParty
    base_uri API_URL
    format :json
    
    # Generating a Ranks Report
    def self.ranks(app_id, granularity, start_date, end_date, options = {})
      get("/reports/ranks/#{app_id}/#{granularity}/#{start_date}/#{end_date}/", options)
    end
  end
end