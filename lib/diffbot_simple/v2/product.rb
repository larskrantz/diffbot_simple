module DiffbotSimple::V2
	# Complies to http://www.diffbot.com/dev/docs/product
	class Product
		include ApiHelper
		def post_initialize
			@api = :product
		end
		def single_product url: nil, **options
			raise ArgumentError.new "Must pass an url to fetch" unless url
			execute_call options.merge(url: url)
		end
	end
end