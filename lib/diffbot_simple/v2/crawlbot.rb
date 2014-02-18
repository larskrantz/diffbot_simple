module DiffbotSimple::V2
	# Complies to http://www.diffbot.com/dev/docs/crawl/
	class Crawlbot
		include DiffbotSimple::Symbolize
		def initialize api_client: nil, token: nil
			@api_client = api_client
			@token = token
		end
		# Get all your crawls as an array
		# The "jobs" parameter is stripped and only the array is returned
		#
		# @return [Array] your jobs from the "jobs"-array in api response
		def all
			response = api_client.get "crawl", {token: token}
			symbolized_json = symbolize response
			symbolized_json[:jobs]
		end
		# Gets, creates or updates a named crawl
		#
		# @name [String] name of the crawl to get/create/update
		# @options [Hash] options from http://www.diffbot.com/dev/docs/crawl/ when updating or creating a crawl
		# @return [Hash] with current parameters for the single crawl
		def single_crawl name: nil, options: {}
			raise ArgumentError.new "Must pass a name for the crawl" unless name
			args = options.merge({token: token, name: name})
			response = api_client.get "crawl", args
			symbolized_json = symbolize response
			jobs = symbolized_json[:jobs]
			jobs.first
		end
		private
		attr_reader :token, :api_client
	end
end
