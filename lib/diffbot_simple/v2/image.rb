module DiffbotSimple::V2
	# Complies to http://www.diffbot.com/dev/docs/image
	class Image
		include ApiHelper
		def post_initialize
			@api = :image
		end
		def request url: nil, **options
			raise ArgumentError.new "Must pass an url to fetch" unless url
			execute_call options.merge(url: url)
		end
	end
end