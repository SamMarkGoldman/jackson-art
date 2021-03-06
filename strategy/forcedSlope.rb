class Strategy::ForcedSlope
	include Strategy

	def set_instance(args)
		@goal_vecs = [
			Point.new(2.5, 2),
			Point.new(-1, 3)
		]
	end

	def angle_within(candidate_line)
		@goal_vecs.each do |vec|
			return true if (candidate_line.vector.unit - vec.unit).magnitude < 0.25
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