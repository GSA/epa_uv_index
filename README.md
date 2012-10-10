# EpaUvIndex

A really simple Ruby client library for accessing the U.S. EPA's UV Index REST API ([More information](http://www.epa.gov/enviro/facts/services.html#uvindex)).

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

## Reporting an Issue

To report an issue or suggest a feature, please use the [issues page](https://github.com/GSA-OCSIT/epa_uv_index/issues).

## Contributing

Federal employees and members of the public are encouraged to contribute to the project by [forking](https://help.github.com/articles/fork-a-repo) and submitting a pull request. (If you are new to GitHub, you might start with a [basic tutorial](https://help.github.com/articles/set-up-git).) Specifically:

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

**Note:** All contributors retain the original copyright to their code, but by contributing to this project, you grant a world-wide, royalty-free, perpetual, irrevocable, non-exclusive, transferable license to all users under the terms of the license under which this project is distributed.

## License

This project constitutes a work of the United States Government and is not subject to domestic copyright protection under 17 USC § 105.

This project is licensed under the MIT License. See `LICENSE.txt` for more information.