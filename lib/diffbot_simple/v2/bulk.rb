module DiffbotSimple::V2
	class Bulk
		attr_reader :parameters, :name
		def initialize bulk_api: nil, name: nil, **parameters
			@bulk_api = bulk_api
			@name = name
			@parameters = parameters
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
		def method_missing property, *args
			super if args.empty?
			h = {}
			property = property.to_s.gsub /\=$/,""
			h[property.to_sym] = args.join(",")
			send_to_api h
		end
		private
		attr_reader :bulk_api
		def send_to_api **options
			params = options.merge({name: name})
			@parameters = bulk_api.single params
			@parameters.delete :name
			self
		end
	end
end