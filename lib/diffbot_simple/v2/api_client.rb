require 'multi_json'
require 'rest-core'
require 'rest-client'
module DiffbotSimple::V2
	ApiClient = RestCore::Builder.client do
		use RestCore::DefaultSite , 'http://api.diffbot.com/v2/'
  	use RestCore::JsonResponse, true
	end
end