module DiffbotSimple::V2
	# Complies to http://www.diffbot.com/dev/docs/product
	class Product
		include ApiHelper
		def single_product url: nil, **options
			raise ArgumentError.new "Must pass an url to fetch" unless url
			execute_call options.merge(url: url, api: :product)
		end
	end
end