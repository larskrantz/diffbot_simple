require_relative 'api_client'
module DiffbotSimple::V2
	class Client
		def initialize token: nil, bulk_api: nil, api_client: nil
			raise ArgumentError.new("Must supply developer token") if token.to_s.empty?
			@token = token
			@api_client = api_client ||= ApiClient.new
			@bulk_api = bulk_api ||= BulkApi.new(api_client: api_client, token: token)
		end
		def crawlbot
			Crawlbot.new api_client: api_client, token: token
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
			return bulk_api.all.map { |e| Bulk.new e.merge(bulk_api: bulk_api)  } unless name
			return Bulk.new (bulk_api.single name: name).merge(bulk_api: bulk_api)
		end
		private
		attr_reader :token, :api_client, :bulk_api
	end
end