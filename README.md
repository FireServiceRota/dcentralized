[![Build Status](https://travis-ci.org/nicka/dcentralized.png?branch=develop)](https://travis-ci.org/nicka/dcentralized) [![Code Climate](https://codeclimate.com/github/nicka/dcentralized.png)](https://codeclimate.com/github/nicka/dcentralized) [![Gem Version](https://badge.fury.io/rb/dcentralized.png)](http://badge.fury.io/rb/dcentralized)

# Dcentralized

API wrapper for Pro6PP zipcode database(d-centralize.nl). 

## Installation

Add this line to your application's Gemfile:

    gem 'dcentralized'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dcentralized

## Setup

Add file `config/initializers/dcentralized.rb`.

    require 'dcentralized'
    Dcentralized.configure do |config|
      config.api_key = "123456789aBcDeFgHiJkLmNoPqRsTuVwXyZ"
    end

## Example usage

High detailed zipcode result:

    response = Dcentralized.auto_complete("2564AZ")
    # => #<OpenStruct nl_sixpp="2564AZ", street="Laan van Meerdervoort", city="'s-Gravenhage", municipality="'s-Gravenhage", province="Zuid-Holland", streetnumbers="1096-1126", lat="52.06751", lng="4.24733", areacode="070">

Low detailed zipcode result:

    response = Dcentralized.auto_complete("2564")
    # => #<OpenStruct nl_fourpp="2564", city="'s-Gravenhage", municipality="'s-Gravenhage", province="Zuid-Holland", areacode="070", lat="52.068", lng="4.25724">

You can then use:

    response.street
    # => "Laan van Meerdervoort"
    response.province
    # => "Zuid-Holland"

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
