require 'httparty'

module Appfigures
  class Sale
    include HTTParty
    base_uri API_URL
    format :json

    TYPE = {:DATES => "dates", :COUNTRIES => "countries", :PRODUCTS => "products", :REGION => "regions",
      :DATES_PRODUCTS => "dates+products", :PRODUCTS_DATES => "products+dates", 
      :COUNTRIES_PRODUCTS => "countries+products", :PRODUCTS_COUNTRIES => "products+countries",
      :COUNTRIES_DATES => "countries+dates", :DATES_COUNTRIES => "dates+countries"
    }

    DATASOURCE = {:DAILY => "daily", :WEEKLY => "weekly", :MONTHLY => "monthly"}
    
    def initialize(username, password)
      @auth = {:username => username, :password => password}
    end
    
    # Generating a By App, By Country, or By Date Sales Report
    # options[:query] can be data_source, apps or country
    def sales(type, start_date, end_date, product_ids, options={})
      raise ArgumentError, "Type must be one of TYPE: #{TYPE.values.join(", ")}" unless TYPE.values.index(type)
      raise ArgumentError, "Type must be one of DATASOURCE: #{DATASOURCE.values.join(", ")}" if (options[:data_source] && !DATASOURCE.values.index(options[:data_source]))

      product_ids = [product_ids] unless product_ids.is_a?(Array)
      options.merge!({:basic_auth => @auth, :product_ids => product_ids.join(";")})
      url = "/sales/#{type}/#{start_date}/#{end_date}/"    
      self.class.get(url, options)
    end

    # Generating all time totals report
    # type must be one of products, products+countries, countries, countries+products
    def alltime_sales(type, product_ids=[], options={})
      accept_types = %w{products products+countries countries countries+products}
      raise ArgumentError, "Type must be one of TYPE: #{accept_types}" unless accept_types.include?(type)
      product_ids = [product_ids] unless product_ids.is_a?(Array)

      options.merge!({:basic_auth => @auth, :products => product_ids.join(";")})
      url = "/reports/sales/#{type}"
      self.class.get(url, options)
    end

    # Generating a By Region Sales Report
    def region_sales(start_date, end_date, options={})
      options.merge!({:basic_auth => @auth})
      url = "/sales/regions/#{start_date}/#{end_date}"    
      self.class.get(url, options)
    end
    
  end
end