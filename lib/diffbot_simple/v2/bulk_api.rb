module DiffbotSimple::V2
	# Complies to http://www.diffbot.com/dev/docs/bulk/
	class BulkApi
		include ApiHelper
		def post_initialize
			@api = :bulk
		end
		def all
			execute_call()[:jobs].select { |e| e[:type] == @api.to_s  }
		end
		def single name: nil, **options
			response = execute_call options.merge(name: name)
			return response[:jobs].select { |e| e[:type] == @api.to_s }.first if response.has_key?(:jobs)
			response
		end
		def results url: nil
			return [] unless url
			response = api_client.get url
			symbolize response
		end
	end
end