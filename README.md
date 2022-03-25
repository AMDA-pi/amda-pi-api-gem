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
# initialize the Amdapi client
client = Amdapi::Client.new(client_id: ENV["client_id"], client_secret: ENV["client_secret"])

# GET one call
client.find(call_uuid)

# GET a batch of calls
client.all(params: search_params)

# Analize a call (create the call info in our DB + analyse asyncronously the audio)
client.analize(params: call_params, file: audio_file)

# Delete a specific audio (this includes delete the call in our Database + the audio)
client.delete(call_uuid)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. For security purposes the stubs for the tests are in the gitignore file.

You can also run `bin/console` for an interactive prompt that will allow you to experiment.
If you whish to start using this gem do not hesitate to contact the AMDApi team to provide you with the correct credentials.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/amdapi.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
