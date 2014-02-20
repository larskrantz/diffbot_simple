module DiffbotSimple::V2
	# Complies to http://www.diffbot.com/dev/docs/image
	class Image
		include ApiHelper
		def single_image url: nil, **options
			raise ArgumentError.new "Must pass an url to fetch" unless url
			execute_call options.merge(url: url, api: :image)
		end
	end
end