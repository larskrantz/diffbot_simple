module DiffbotSimple::V2
	# Complies to http://www.diffbot.com/dev/docs/crawl/
	module ApiHelper
		include DiffbotSimple::Symbolize
		def initialize api_client: nil, token: nil
			@api_client = api_client
			@token = token
		end
		private
		attr_reader :token, :api_client
		def execute_call api: nil, custom_headers: nil, method: :get, payload: nil, **options
			args = options.merge({token: token})
			opts = {}
			opts[:headers] = custom_headers if custom_headers
			response = api_client.get(api, args, opts) if method == :get
			response = api_client.post(api, payload, args, opts) if method == :post
			result_hash = symbolize response
			raise_if_error_response result_hash
			result_hash
		end
		def raise_if_error_response result_from_diffbot
			return unless result_from_diffbot[:error]
			raise DiffbotError.new(result_from_diffbot[:error], result_from_diffbot[:errorCode])
		end
	end
end