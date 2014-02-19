module DiffbotSimple::V2
	class DiffbotError < StandardError
		attr_reader :error_code
		def initialize error_message, error_code = nil
			@error_code = error_code
			super error_message
		end
	end
end