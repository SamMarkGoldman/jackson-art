class Strategy::SparceSlope < Strategy::ForcedSlope
	include Strategy

	HEAT_MAP_INC = 25.0

	def set_instance
		@goal_vecs = [
			Point.new(2.5, 2),
			Point.new(-1, 3)
		]
		@heat_map = HeatMap.new(HEAT_MAP_INC)
	end

	def generate
		start_point_candidates = []
		20.times.each { start_point_candidates << @canvas.lines.sample.random_point }
		best_start_point = start_point_candidates.min{ |p| @heat_map.point_proximity_score(p) }
		candidate_line = Line.new(best_start_point, start_point_candidates[3])
		# begin 
		# 	candidate_line = random_line
		# end until angle_within(candidate_line)
		@heat_map.add_line(candidate_line)
		candidate_line
	end
end