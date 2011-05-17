require 'httparty'

module Appfigures
  class Sale
    include HTTParty
    base_uri API_URL
    format :json
    
    TYPE = {:APPS => "apps", :DATES => "dates", :COUNTRIES => "countries", :APPS_DATES => "apps+dates", :DATES_APPS => "dates+apps"}
    DATASOURCE = {:DAILY => "daily", :WEEKLY => "weekly", :MONTHLY => "monthly"}
    
    # Generating a By App, By Country, or By Date Sales Report
    # options[:query] can be data_source, apps or country
    def self.sales(type, start_date, end_date, options={})
      raise ArgumentError, "Type must be one of TYPE: #{TYPE.values.join(", ")}" unless TYPE.values.index(type)
      raise ArgumentError, "Type must be one of DATASOURCE: #{DATASOURCE.values.join(", ")}" if (options[:data_source] && !DATASOURCE.values.index(options[:data_source]))

      url = "/sales/#{type}/#{start_date}/#{end_date}/"    
      get(url, options)
    end
    
    # Generating a By Region Sales Report
    def self.region_sales(itc_id, start_date, end_date, options={})
      url = "/reports/sales/#{itc_id}/regions/#{start_date}/#{end_date}"    
      get(url, options)
    end
    
  end
end