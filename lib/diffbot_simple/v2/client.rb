require_relative 'api_client'
module DiffbotSimple::V2
	class Client
		def initialize token: nil
			raise ArgumentError.new("Must supply developer token") if token.to_s.empty?
			@token = token
			@api_client = ApiClient.new
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
			return bulk_factory.all unless name
		end
		private
		attr_reader :token, :api_client
		def bulk_factory
			BulkFactory.new api_client: api_client, token: token
		end
	end
end