require "rest-client"
require "xmlsimple"
require "hash_symbolizer"
require "dcentralized/version"

module Dcentralized
  class << self
    attr_accessor :api_url, :auth_key
    def configure(&blk); class_eval(&blk); end
  end

  def self.auto_complete(zipcode)
    # Format the zipcode
    zipcode = format_zipcode(zipcode)
    # Setup request
    params   = {auth_key: @auth_key} 
    zipcode.length == 6 ? params.merge!(nl_sixpp: zipcode) : params.merge!(nl_fourpp: zipcode)
    params.merge!(format: 'xml', pretty: 'True')
    # Perform request and return output
    response = RestClient.get "#{@api_url}/autocomplete", {params: params}
    stringify(XmlSimple.xml_in(response)["results"][0]["result"][0].symbolize_keys(true))
  end

  def self.format_zipcode(zipcode = nil)
    if zipcode.nil? || zipcode == ""
      raise Exception.new("No zipcode provided")
    elsif (zipcode =~ /^[1-9]{4}$|[1-9]{4}[\ ]{1}[a-zA-Z]{2}$|[1-9]{4}[a-zA-Z]{2}$/).nil?
      raise Exception.new("Wrong zipcode format (1234AB format expected)")
    else
      zipcode.gsub(" ", "").upcase
    end
  end

  def self.stringify(obj)
    if obj.is_a? Array
      obj.join
    elsif obj.is_a? Hash
      obj.merge( obj ) {|k, val| stringify val }
    end
  end

  def self.version_string
    "Dcentralized version #{Dcentralized::VERSION}"
  end
end

# Set default configuration
Dcentralized.configure do
  @api_url  = "http://api.pro6pp.nl/v1"
  @auth_key = "123456789aBcDeFgHiJkLmNoPqRsTuVwXyZ"
end