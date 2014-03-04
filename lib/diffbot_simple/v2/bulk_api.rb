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
			response[:jobs].first
		end
	end
end