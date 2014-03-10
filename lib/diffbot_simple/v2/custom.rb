module DiffbotSimple::V2
	# Complies to http://www.diffbot.com/dev/docs/custom
	class Custom
		include ApiHelper
		attr_reader :name
		def initialize name: nil, **options
			raise ArgumentError.new "Must pass a name for the custom api" unless name
			@name = name.to_s
			super options
		end
		def post_initialize
			@api = "api/#{CGI::escape(name)}"
		end
	end
end