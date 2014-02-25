module DiffbotSimple::V2
	# Complies to http://www.diffbot.com/dev/docs/article
	class Article
		include ApiHelper
		def post_initialize
			@api = :article
		end
		def single_article url: nil, custom_headers: nil, body: nil, **options
			raise ArgumentError.new "Must pass an url for the article api to fetch" unless url
			if body
				custom_headers ||= {}
				custom_headers['Content-Type'] = 'text/html'
				options[:method] = :post
			end
			execute_call options.merge(url: url, custom_headers: custom_headers, payload: body)
		end
	end
end