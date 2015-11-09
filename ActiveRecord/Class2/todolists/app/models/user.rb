class User < ActiveRecord::Base
	has_one :profile, dependent: :destroy
	has_many :todo_lists, dependent: :destroy
	belongs_to :todo_list
	has_many :todo_items, through: :todo_lists, source: :todo_items, dependent: :destroy
	
	validates :username, presence: true
	
	def get_completed_count(username)
		sum = 0
		User.includes(:todo_list).includes(:todo_items).find( username).todo_lists.each{|li| sum+=li.todo_items.where(completed: true).count}
		sum
	end
end
