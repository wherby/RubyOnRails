class TodoItem < ActiveRecord::Base
	def self.get_complete
		TodoItem.where(completed: true).count
	end
end
