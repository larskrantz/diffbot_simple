module DiffbotSimple::V2
	# Complies to http://www.diffbot.com/dev/docs/analyze
	class Analyze
		include ApiHelper
		def single_analysis url: nil, **options
			raise ArgumentError.new "Must pass an url to fetch" unless url
			execute_call options.merge(url: url, api: :analyze)
		end
		alias :single_analyze :single_analysis
	end
end