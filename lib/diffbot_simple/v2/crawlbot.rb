module DiffbotSimple::V2
	class Crawlbot
		def initialize api_client: nil, token: nil
			@api_client = api_client
			@token = token
		end
		def all_crawls
			api_client.get "crawl", {token: token}
		end
		private
		attr_reader :token, :api_client
	end
end