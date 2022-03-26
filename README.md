# Amdapi

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/amdapi`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'amdapi'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install amdapi

## Usage

```ruby
client = Amdapi::Client.new(client_id: ENV["client_id"], client_secret: ENV["client_secret"])
client.find(call_uuid)
client.all(params)
client.create(audio_url)
client.destroy(client_uuid)
```
## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
