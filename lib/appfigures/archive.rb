require 'httparty'

module Appfigures
  class Archive
    include HTTParty
    base_uri API_URL
    format :json
    TYPE = {
      :DAILY => "daily",
      :WEEKLY => "weekly",
      :FINANCIAL => "financial",
      :PAYMENT => "payment",
      :ALL => "all"
    }

    def initialize(username, password)
      @auth = {:username => username, :password => password}
    end
    
    def archives(type="all")
      raise ArgumentError, "Type must be one of TYPE: #{TYPE.values.join(", ")}" unless TYPE.values.index(type)
      self.class.get("/archive", {:basic_auth => @auth, :type => type})
    end
    
    def latest(type="all")
      self.class.get("/archive/latest", {:basic_auth => @auth, :type => type})
    end
    
    def by_date(date, type="all")
      self.class.get("/archive/#{date}", {:basic_auth => @auth, :type => type})
    end

    # get the raw report by report id
    # requires admin
    def raw(id)
      self.class.get("/archive/raw/#{id}", {:basic_auth => @auth})
    end

  end
end