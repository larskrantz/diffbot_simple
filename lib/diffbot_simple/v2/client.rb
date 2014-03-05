require_relative 'api_client'
module DiffbotSimple::V2
	class Client
		def initialize token: nil, bulk_api: nil, api_client: nil, crawlbot_api: nil
			raise ArgumentError.new("Must supply developer token") if token.to_s.empty?
			@token = token
			@api_client = api_client ||= ApiClient.new
			@bulk_api = bulk_api ||= BulkApi.new(api_client: api_client, token: token)
			@crawlbot_api = crawlbot_api ||= CrawlbotApi.new(api_client: api_client, token: token)
		end
		def article
			Article.new api_client: api_client, token: token
		end
		def custom name: nil
			Custom.new api_client: api_client, token: token, name: name
		end
		def product
			Product.new api_client: api_client, token: token
		end
		def image
			Image.new api_client: api_client, token: token
		end
		def analyze
			Analyze.new api_client: api_client, token: token
		end
		def bulk name: nil
			return bulk_api.all.map { |e| Bulk.new name: e.delete(:name), init: e, bulk_api: bulk_api  } unless name
			return Bulk.new name: name, bulk_api: bulk_api
		end
		def crawl name: nil
			return crawlbot_api.all.map { |e| Crawl.new name: e.delete(:name), init: e, crawlbot_api: crawlbot_api  } unless name
			return Crawl.new name: name, crawlbot_api: crawlbot_api
		end
		private
		attr_reader :token, :api_client, :bulk_api, :crawlbot_api
	end
end