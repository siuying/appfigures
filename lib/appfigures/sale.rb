require 'httparty'

module Appfigures
  class Sale
    include HTTParty
    base_uri API_URL
    format :json

    def self.sales(type, start_date, end_date, options={})
      get('/sales/#{type}/#{start_date}/#{end_date}/', :query => options)
    end
  end
end