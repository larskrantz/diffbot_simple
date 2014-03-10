module DiffbotSimple::V2
	# Complies to http://www.diffbot.com/dev/docs/bulk/
	class BulkApi < CrawlbotApi
		def post_initialize
			@api = :bulk
		end
	end
end