class Child < ActiveRecord::Base
	has_and_belongs_to_many :parents
	has_many :child_events
	accepts_nested_attributes_for :parents, allow_destroy: true
	
	belongs_to :rate
	
	####################################
	# Returns the first,
	# middle, and last names of the
	# child concatenated into a friendly
	# string
	####################################
	def full_name
		"#{fname} #{lname}"
	end
	
	
	#############################################
	# Get the child_event with the
	# most recent start_time
	##############################################
	def current_event
		@last_child_event = nil
	
		# if there is an event to return
		if !self.child_events.nil?
			@last_child_event = self.child_events.order('start_time DESC').first
		end
	end
	
	
	#############################################
	# Get the child_event with the
	# most recent start_time
	##############################################
	def current_event=( event )
		# if there is an event to return
		#write_attribute(self.child_events.order('start_time DESC').first, event)
	end
	
	
	#############################################
	# Decides if a child is in care right now
	# based on whether the child_event with the
	# most recent start_time has a corresponding
	# end_time (i.e. whether the last event is
	# still running/incomplete)
	##############################################
	def in_care?
		last_child_event = self.current_event
		
		if last_child_event && last_child_event.end_time == nil
			return true
		end
		
		return false
	end
	
	
	
	
	
	#############################################
	# Creates a child 
	##############################################
	def arrive
		if self.in_care?
			return false
		end
		
		self.child_events.build(start_time: Time.now, parent_id: params[:parent_guardian_id])
	end
	
	
	def depart( parent_guardian_id )
		if !self.in_care?
			return false
		end
		
		event = self.child_events.order('start_time DESC').first
		
		event.end_time = Time.now
		event.parent_id = parent_guardian_id
	end	
end