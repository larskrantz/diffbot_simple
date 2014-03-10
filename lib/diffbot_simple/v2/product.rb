module DiffbotSimple::V2
	# Complies to http://www.diffbot.com/dev/docs/product
	class Product
		include ApiHelper
		def post_initialize
			@api = :product
		end
	end
end