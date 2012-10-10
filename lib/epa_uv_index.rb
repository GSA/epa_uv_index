require "epa_uv_index/version"
require 'httparty'
require 'json'

module EpaUvIndex
  class Client
    
    HOURLY_BASE_URL = "http://iaspub.epa.gov/enviro/efservice/getEnvirofactsUVHOURLY"
    DAILY_BASE_URL = "http://iaspub.epa.gov/enviro/efservice/getEnvirofactsUVDAILY"
    
    def self.hourly_for(params)
      begin
        do_request(HOURLY_BASE_URL, params)
      rescue Exception => e
        raise e
      end
    end
  
    def self.daily_for(params)
      begin
        do_request(DAILY_BASE_URL, params)
      rescue Exception => e
        raise e
      end
    end
  
    protected
  
    def self.do_request(base_url, params)
      raise Exception("Please provide either a city/state or a zip code.") unless params[:zip] or (params[:city] and params[:state])
      request_url = build_request_url(base_url, params)
      http_response = HTTParty.get(request_url)
      begin
        evaluate_response(http_response)
      rescue Exception => e
        raise e
      end      
    end
  
    def self.build_request_url(base_url, params)
      if params[:zip]
        "#{base_url}/ZIP/#{params[:zip]}/json"
      else
        "#{base_url}/CITY/#{params[:city]}/#{params[:state]}/json"
      end
    end
  
    def self.evaluate_response(http_response)
      if http_response.code == 200
        return JSON.parse(http_response.body)
      else
        raise Exception(http_response.message)
      end
    end
  end
end