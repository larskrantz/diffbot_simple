module DiffbotSimple::V2
	class Crawlbot
		include DiffbotSimple::Symbolize
		def initialize api_client: nil, token: nil
			@api_client = api_client
			@token = token
		end
		def all
			response = api_client.get "crawl", {token: token}
			symbolize response
		end
		def get_crawl name: nil
			response = api_client.get "crawl", {token: token, name: name}
			symbolize response
		end
		private
		attr_reader :token, :api_client
	end
end
