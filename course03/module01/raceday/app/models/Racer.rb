class Racer
	def self.mongo_client
		Mongoid::Clients.default
	end
	
	def self.collection
		self.mongo_client['racers']
	end
	
	def self.all(prototype={}, sort={:number => 1},skip=0,limit=nil)
		tmp = {}
		sort.each {|k,v| 
      		k = k.to_sym==:population ? :pop : k.to_sym
      		tmp[k] = v  if [:number, :first_name, :last_name, :gender, :group,:secs].include?(k)
    	}
		sort=tmp
		prototype=prototype.symbolize_keys.slice(:number, :first_name, :last_name, :gender, :group,:secs) if !prototype.nil?
		result=collection.find(prototype)
          .projection({number:true, first_name:true, last_name:true, gender:true,group:true,secs:true})
          .sort(sort)
          .skip(skip)	
		result=result.limit(limit) if !limit.nil?
		return result
	end
end	