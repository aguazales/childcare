class Vehicle < ActiveRecord::Base
	belongs_to :user
	has_many :expenses
	validates :user_id, presence: true
	
	#############################################
	# Returns a string containing the year, make, 
	# and model of the current car
	##############################################
	def full_description
		"#{year} #{make} #{model}"
	end
end
