[![Coverage Status](https://coveralls.io/repos/larskrantz/diffbot_simple/badge.png)](https://coveralls.io/r/larskrantz/diffbot_simple)
[![Build Status](https://travis-ci.org/larskrantz/diffbot_simple.png?branch=master)](https://travis-ci.org/larskrantz/diffbot_simple)
[![Code Climate](https://codeclimate.com/github/larskrantz/diffbot_simple.png)](https://codeclimate.com/github/larskrantz/diffbot_simple)
[![Gem Version](https://badge.fury.io/rb/diffbot_simple.png)](http://badge.fury.io/rb/diffbot_simple)

DiffbotSimple
=============

A simple, nothing-fancy, helper for the [Diffbot API](http://www.diffbot.com/).

Will not objectify any responses, however Bulk and CrawlBot are a bit wrapped. 
For these two apis, it will not care about the success-message and will only take care of things in the `:jobs`-array

For the other apis, just pass on the json data as hash with symbolized keys to the request.
Send options to the api as named args, se usage below with article and fields-argument.

## Installation
```ruby
gem 'diffbot-simple'
```

## Dependencies
* Ruby 2.0 or 2.1
* [rest-core](https://github.com/cardinalblue/rest-core)
* [multi_json](https://github.com/intridea/multi_json)


## Usage
```ruby
require 'diffbot_simple'

token = "my_diffbot_assigned_token"
client = DiffbotSimple::V2::Client.new token: token

article = client.article
url = "http://www.xconomy.com/san-francisco/2012/07/25/diffbot-is-using-computer-vision-to-reinvent-the-semantic-web/"
# Pass on diffbot parameters as options to the call
diffbot_response_as_symbolized_hash = article.request url: url, fields: "icon,title"
# =>
{
  icon: "http://www.xconomy.com/wordpress/wp-content/themes/xconomy/images/favicon.ico",
  author: "Wade Roush",
  date: "7/25/12",
  text: "...",
# and more, see http://www.diffbot.com/products/automatic/article/
}
```

### Supports these Diffbot apis
Please see [Diffbot Help and Documentation](http://www.diffbot.com/dev/docs/) for details and arguments.
Check the spec-directory too.

```ruby
require 'diffbot_simple'

token = "my_diffbot_assigned_token"
client = DiffbotSimple::V2::Client.new token: token
url = "http://some_url_to_check"

# Custom API
# will raise error if not exists, must create at http://www.diffbot.com/dev/customize/
custom = client.custom name: "my_custom_api_name" 
response = custom.request url: url 

# Analyze API (beta)
analyze = client.analyze 
response = analyze.request url: url

# Article API
article = client.article
response = article.request url: url

# Image API
image = client.image
response = image.request url: url

# Product API
product = client.product
response = product.request url: url

# Crawlbot API
all_my_crawls = client.crawl
crawl = client.crawl name: "mycrawl"
current_parameters = crawl.parameters
# shorthand for using apiUrl, use the api object from client, 
# it will create a correct value for you 
# (custom, image, article, product or analyze for automatic)
crawl.apiUrl = product # the object from above
# A call to client.crawl name: "mycrawl" will create if not exists 
# (works with a symbol too, client.crawl name: :mycrawl)
# To update parameters: 
craw.update onlyProcessIfNew: 0, seeds: "http://www.upptec.se", apiUrl: custom
# or by method, works only on loaded parameters
crawl.onlyProcessIfNew = 0 # sends update immediatly to diffbot
crawl.seeds = "http://www.upptec.se" # sends update immediatly to diffbot
# direct access by name to:
current_seeds = crawl.seeds
# actions:
crawl.pause
crawl.unpause
crawl.restart
# results is shorthand for downloading the json that are specifed in :downloadJson
results = crawl.results 
crawl.delete! 

# Bulk API
# is based on crawlbot and works exactly the same
all_my_bulk_jobs = client.bulk
bulk = client.bulk name: "mycrawl"
current_parameters = bulk.parameters
# and so forth as crawlbot above.
# however, you can add urls to process as an array using the #process method:
bulk.process ["http://foo.bar", "http://bar.foo"] 

```

### On error
If Diffbot returns an error, it will raise and fill `DiffbotSimple::V2::DiffbotError` with passed on info, as stated in [http://www.diffbot.com/dev/docs/error/](http://www.diffbot.com/dev/docs/error/) and put errorCode in `:error_code` and error in `:message` .

## TODO
* Frontpage API
* Async http fetching
* Batch API

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

