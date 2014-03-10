module DiffbotSimple
	module Symbolize
    def symbolize hash
    	return hash unless hash.kind_of? Hash or hash.kind_of? Array
      sym_hash = y_combinator do |&f| 
      	lambda do |h|
	      	if h.kind_of? Array
	      		h.map {|r| f.call(r)}
	      	elsif h.kind_of? Hash
	        	h.reduce({}) do |memo,(k,v)|
	          	v = f.call(v) if v.kind_of? Hash
	        		v = v.map {|u| f.call(u)} if v.kind_of? Array
	        		memo[k.to_sym] = v
	        		memo
	        	end
	        else
	        	h
		    	end
	    	end
	    end
  	  sym_hash.call hash
  	end

  	private
    def y_combinator(&f)
      lambda do |g|
        f.call {|*args| g[g][*args]}
      end.tap {|g| break g[g]}
    end
  	module_function :symbolize, :y_combinator
	end
end