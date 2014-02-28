module DiffbotSimple::V2
	class Bulk
		attr_reader :parameters
		def initialize  **parameters
			@parameters = parameters
		end
	end
end