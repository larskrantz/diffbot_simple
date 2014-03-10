module DiffbotSimple::V2
	module ApiHelper
		include DiffbotSimple::Symbolize
		def initialize api_client: nil, token: nil
			@api_client = api_client
			@token = token
			post_initialize
		end
		def post_initialize
			raise "Must overload to set api path"
		end
		def to_api_url
			"#{api_client.site}#{api}"
		end
		# overload if necessary
		def request url: nil, **options
			raise ArgumentError.new "Must pass an url for the request to work" unless url
			execute_call options.merge(url: url)
		end
		private
		attr_reader :token, :api_client, :api
		def execute_call custom_headers: nil, method: :get, payload: nil, **options
			args = create_from_options options
			opts = {}
			opts[:headers] = custom_headers if custom_headers
			response = api_client.get(api, args, opts) if method == :get
			response = api_client.post(api, payload, args, opts) if method == :post
			cleanup response
		end
		def cleanup response
			result_hash = symbolize response
			raise_if_error_response result_hash
			result_hash
		end
		def create_from_options options
			merged = options.merge({token: token})
			merged[:apiUrl] = expand_api_url merged[:apiUrl] if merged[:apiUrl]
			merged
		end
		def expand_api_url api_url
			return api_url.to_api_url if api_url.respond_to?(:to_api_url)
			return api_url
		end
		def raise_if_error_response result_from_diffbot
			return unless result_from_diffbot[:error]
			raise DiffbotError.new(result_from_diffbot[:error], result_from_diffbot[:errorCode])
		end
	end
end