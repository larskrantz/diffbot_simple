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
	end
end