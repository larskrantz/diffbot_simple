module DiffbotSimple::V2
	class Bulk < Crawl
		def initialize bulk_api: nil, name: nil, init: {}, **parameters
			super parameters.merge(name: name, crawlbot_api: bulk_api, init: init)
		end
		def process urls_to_process
			urls_to_process = [urls_to_process] unless urls_to_process.respond_to? :join
			send_to_api urls: urls_to_process.join(" ")
		end
	end
end