module DiffbotSimple
	module Symbolize
		private
    def y_combinator(&f)
      lambda do |g|
        f.call {|*args| g[g][*args]}
      end.tap {|g| break g[g]}
    end

    def symbolize hash
    	return unless hash.kind_of? Hash
      sym_hash = y_combinator do |&f| 
      	lambda do |h|
	      	if h.kind_of? Array
	      		h.map {|r| f.call(r)}
	      	else
	        	h.reduce({}) do |memo,(k,v)|
	          	v = f.call(v) if v.kind_of? Hash
	        		v = v.map {|u| f.call(u)} if v.kind_of? Array
	        		memo[k.to_sym] = v
	        		memo
	        	end
		    	end
	    	end
	    end
  	  sym_hash.call hash
  	end
	end
end