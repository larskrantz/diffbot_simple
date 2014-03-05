module DiffbotSimple::V2
	class Crawl
		attr_reader :parameters, :name
		def initialize crawlbot_api: nil, name: nil, init: {}, **parameters
			@crawlbot_api = crawlbot_api
			@name = name
		 	if init.empty?
				send_to_api parameters
			else
				@parameters = init
			end
		end
		def pause
			send_to_api pause: 1
		end
		def unpause
			send_to_api pause: 0
		end
		def delete!
			send_to_api delete: 1
		end
		def restart
			send_to_api restart: 1
		end
		def update **parameters
			send_to_api parameters
		end
		def results
			crawlbot_api.results url: parameters[:downloadJson]
		end
		def method_missing property, *args
			property = property.to_s.gsub(/\=$/,"").to_sym
			super unless parameters.has_key? property
			send_to_api({ property => args.join(",") })
		end
		private
		attr_reader :crawlbot_api
		def send_to_api **options
			params = options.merge({name: name})
			@parameters = crawlbot_api.single params
			@parameters.delete :name
			self
		end
	end
end