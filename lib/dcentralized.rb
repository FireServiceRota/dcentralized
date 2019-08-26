# frozen_string_literal: true

require 'ostruct'
require 'dcentralized/version'
require 'dcentralized/invalid_postcode_exception'
require 'net/http'

module Dcentralized
  class << self
    attr_accessor :api_url, :api_key
    def configure(&blk)
      class_eval(&blk)
    end
  end

  def self.auto_complete(zipcode, house_number = nil)
    # Format the zipcode
    zipcode = format_zipcode(zipcode)
    # Setup request
    params  = { auth_key: @api_key }
    zipcode.length == 6 ? params.merge!(nl_sixpp: zipcode) : params.merge!(nl_fourpp: zipcode)
    params.merge!(format: 'json')
    params.merge!(streetnumber: house_number) if house_number

    # Perform request
    url = "#{@api_url}/autocomplete"
    uri = URI.parse(url)
    uri.query = URI.encode_www_form(params)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    response = JSON.parse(http.request(request).body)

    return OpenStruct.new response['results'].first if response['status'] == 'ok'

    if response['status'] == 'error'
      raise InvalidPostcodeException, response['error']['message']
    end

    raise Exception, 'Unknown exception in Pro6PP auto_complete response'
  end

  def self.format_zipcode(zipcode = nil)
    raise InvalidPostcodeException, 'No zipcode provided' if zipcode.nil? || zipcode == ''

    regexp = /^[0-9]{4}$|[0-9]{4}[\ ]{1}[a-zA-Z]{2}$|[0-9]{4}[a-zA-Z]{2}$/
    if (zipcode =~ regexp).nil?
      raise InvalidPostcodeException, 'Wrong zipcode format (1234AB format expected)'
    end

    zipcode.gsub(' ', '').upcase
  end

  def self.stringify(obj)
    if obj.is_a? Array
      obj.join
    elsif obj.is_a? Hash
      obj.merge(obj) { |_k, val| stringify val }
    end
  end

  def self.version_string
    "Dcentralized version #{Dcentralized::VERSION}"
  end
end

# Set default configuration
Dcentralized.configure do
  @api_url = 'https://api.pro6pp.nl/v1'
  @api_key = '123456789aBcDeFgHiJkLmNoPqRsTuVwXyZ'
end
