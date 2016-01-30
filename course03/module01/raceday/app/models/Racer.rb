require 'BSON'
class Racer
	include ActiveModel::Model
	attr_accessor :id, :number, :first_name, :last_name, :gender, :group, :secs
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
	
	def to_s
    	"#{@id}: #{@number}, #{@first_name},#{@last_name},#{@gender},#{@secs}"
  	end
  
	def initialize(params={})
		@id=params[:_id].nil? ? params[:id] : params[:_id].to_s
		@number=params[:number].to_i
		@first_name=params[:first_name]
		@last_name=params[:last_name]
		@gender=params[:gender]
		@group=params[:group]
		@secs=params[:secs].to_i
	end
	
	def self.find id
		Rails.logger.debug {"getting Racer #{id}"}
	
		result=collection.find(:_id=>BSON::ObjectId.from_string(id))
					.projection({number:true, first_name:true, last_name:true, gender:true,group:true,secs:true})
					.first
		return result.nil? ? nil : Racer.new(result)
	end 
	
	def save 
		Rails.logger.debug {"saving #{self}"}
	
		result=self.class.collection
				.insert_one(_id:@id, number:@number, first_name:@first_name, last_name:@last_name,gender:@gender,group:@group,secs:@secs)
		
		@id = result.inserted_id.to_s
	end
	
	def update(params)
		@number=params[:number].to_i
		@first_name=params[:first_name]
		@last_name=params[:last_name]
		@secs=params[:secs].to_i
		@group =params[:group]
		@gender = params[:gender]
		params.slice!(:number, :first_name, :last_name, :gender, :group, :secs)
		self.class.collection.find(:_id=>BSON::ObjectId.from_string(@id))
            .replace_one(params)
	end
	
	def destroy
		Rails.logger.debug {"destroying #{self}"}
		
		self.class.collection
				.find(:_id=>BSON::ObjectId.from_string(@id))
				.delete_one   
	end  
	
	# ActiveModel
	def persisted?
		!@id.nil?
	end
	
	def created_at
		nil
	end
	def updated_at
		nil
	end
end	