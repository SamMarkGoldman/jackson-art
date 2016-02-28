class Strategy::ForcedSlope
	include Strategy

	def set_instance
		@goal_vecs = [
			Point.new(1, 2),
			Point.new(-1, 2)
		]
	end

	def angle_within(candidate_line)
		@goal_vecs.each do |vec|
			return true if (candidate_line.vector.unit - vec.unit).magnitude < 0.2
		end
		false
	end

	def generate
		begin 
			candidate_line = random_line
		end until angle_within(candidate_line)
		candidate_line
	end
end