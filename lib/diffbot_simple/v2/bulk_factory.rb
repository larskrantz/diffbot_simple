module DiffbotSimple::V2
	# Complies to http://www.diffbot.com/dev/docs/bulk/
	class BulkFactory
		include ApiHelper
		def post_initialize
			@api = :bulk
		end
		def all
			execute_call()[:jobs].map { |e| create_bulk e  }
		end
		def single name: nil, **options
			response = execute_call options.merge(name: name)
			job = response[:jobs].first
			create_bulk job
		end
		private
		def create_bulk **parameters
			Bulk.new parameters.merge(bulk_factory: self)
		end
	end
end