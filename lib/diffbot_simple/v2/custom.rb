module DiffbotSimple::V2
	# Complies to http://www.diffbot.com/dev/docs/custom
	class Custom
		include ApiHelper
		attr_reader :name
		def initialize name: nil, **options
			raise ArgumentError.new "Must pass a name for the custom api" unless name
			@name = name
			super options
		end
		def post_initialize
			@api = "api/#{CGI::escape(name)}"
		end
		def request url: nil, **options
			raise ArgumentError.new "Must pass an url for the custom api to fetch" unless url
			execute_call options.merge(url: url)
		end
	end
end