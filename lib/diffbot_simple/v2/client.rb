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
		private
		attr_reader :token, :api_client
	end
end