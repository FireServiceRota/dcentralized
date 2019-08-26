# frozen_string_literal: true

require 'rspec'
require 'vcr'
require 'webmock'
require 'simplecov'
SimpleCov.start
require 'dcentralized'

RSpec.configure do |config|
  config.formatter = 'documentation'
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr'
  config.hook_into :webmock
end
