# EpaUvIndex

This is a really simple Ruby client library for accessing the U.S. EPA's UV Index REST API (information here: http://www.epa.gov/enviro/facts/services.html#uvindex)

## Installation

Add this line to your application's Gemfile:

    gem 'epa_uv_index'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install epa_uv_index

## Usage

Retrieve UV indexes for:

Hourly, by zip code

    $ EpaUvIndex::Client.hourly_for(:zip => 21209)

Hourly, by city/state

    $ EpaUvIndex::Client.hourly_for(:city => 'Baltimore', :state => 'md')
    
Daily, by zip code

    $ EpaUvIndex::Client.daily_for(:zip => 21209)

Daily, by city/state

    $ EpaUvIndex::Client.daily_for(:city => 'Baltimore', :state => 'md')
    
Missing parameters or bad HTTP responses result in Exceptions being raised.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request