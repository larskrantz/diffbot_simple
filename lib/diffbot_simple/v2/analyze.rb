module DiffbotSimple::V2
	# Complies to http://www.diffbot.com/dev/docs/analyze
	class Analyze
		include ApiHelper
		def post_initialize
			@api = :analyze
		end
		def to_crawl_api_url
			default = super
			"#{default}?mode=auto"
		end
		def request url: nil, **options
			raise ArgumentError.new "Must pass an url to fetch" unless url
			execute_call options.merge(url: url)
		end
	end
end