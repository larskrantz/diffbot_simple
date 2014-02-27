module DiffbotSimple::V2
	# Complies to http://www.diffbot.com/dev/docs/bulk/
	class BulkFactory
		include ApiHelper
		def post_initialize
			@api = :bulk
		end
		def all
			execute_call()[:jobs].map { |e| Bulk.new e.merge(bulk_factory: self) }
		end
	end
end