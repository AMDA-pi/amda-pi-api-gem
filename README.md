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
## initialize the Amdapi client
client = Amdapi::Client.new(client_id: ENV["client_id"], client_secret: ENV["client_secret"])

## GET one call
client.find(call_uuid)

## GET a batch of calls
client.all(params: search_params_hash) # based on the filters you have provided
client.all # will get the first page of the calls linked to your entreprise

## Analyze a call (create the call info in our DB + analyse asyncronously the audio)
client.analyze(params: call_params_hash, file: audio_file)

## Delete a specific audio (this includes delete the call in our Database + the audio)
client.delete(call_uuid)
```
### Search params
| key | description | format |
| --- | ----------- | ------ |
| **client_id** | look for calls that only belong to a specific `client` | integer |
| **agent_id** | look for calls that only belong to a specific `agent` | integer |
| **customer_id** | look for calls that only belong to a specific `customer` | integer |
| **start_date** | ook for all calls that have been made from  start_date until the current date unless end_date is provided | DD/MM/YYYY |
| **end_date** | look for all the calls that have been made from start_date until end_date | DD/MM/YYYY |

```JSON
{
	"agent_id": 42,
	"client_id": 420,
	"customer_id": 152,
	"start_date": "24/01/2021",
	"end_date": "04/05/2021"
}
```

### Call params
| key | description | format |
| --- | ----------- | ------ |
| **company_name** | The name of your company | string |
| **call_id** | The ID of the call from your DB | string |
| **client_id** | The ID of your client. The one that operates the contact center | integer |
| **agent_id** | The ID of the agent that operates the call. Value from your DB | integer |
| **customer_id** | The ID of the customer that makes/receives the call. Value from your DB | integer |
| **origin** | Was the call Inbound -or- Outbound? | string |
| **language** | ISO code of the language used in the call. Values currently available: en - en-in - fr | string |
| **summary** | Generates an automatic summary of the conversation if the value is true | boolean |
| **filename** | The name of the call recording file | string |

```JSON
{
	"company_name": "your_company_name",
	"call_id": 273,
	"client_id": 412,
	"agent_id": 42,
	"customer_id": 140,
	"origin": "Inbound",
	"language": "en-in",
	"summary": true,
	"filename": "name_of_the_audio_file"
}
```

### File
The file can be sent the following way. Needs to be a .wav format

```ruby
    file = File.read('[path to the audio file]')
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
