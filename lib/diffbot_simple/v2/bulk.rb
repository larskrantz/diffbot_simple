module DiffbotSimple::V2
	# Complies to http://www.diffbot.com/dev/docs/bulk/
	class Bulk
		attr_reader :parameters
		def initialize bulk_factory: nil, **parameters
			@parameters = parameters
			@bulk_factory = bulk_factory
		end
	end
end