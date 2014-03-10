module DiffbotSimple::V2
	# Complies to http://www.diffbot.com/dev/docs/image
	class Image
		include ApiHelper
		def post_initialize
			@api = :image
		end
	end
end