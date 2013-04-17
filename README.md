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

    require 'airbrake'
    Dcentralized.configure do |config|
      config.api_key = "123456789aBcDeFgHiJkLmNoPqRsTuVwXyZ"
    end

## Usage

**Example**

    Dcentralized.auto_complete("2564AZ")
    # => {
      "nl_sixpp":["2564AZ"],
      "street":["Laan van Meerdervoort"],
      "city":["'s-Gravenhage"],
      "municipality":["'s-Gravenhage"],
      "province":["Zuid-Holland"],
      "streetnumbers":["1096-1126"],
      "lat":["52.06751"],
      "lng":["4.24733"],
      "areacode":["070"]
    }

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
