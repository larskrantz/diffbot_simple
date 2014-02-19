module DiffbotSimple::V2
	# Complies to http://www.diffbot.com/dev/docs/article
	class Article
		include ApiHelper

		def single_article url: nil, **options
			raise ArgumentError.new "Must pass an url for the article api to fetch" unless url
			execute_call options.merge(url: url, api: :article)
		end
	end
end