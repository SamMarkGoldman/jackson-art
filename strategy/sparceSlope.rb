class Strategy::SparceSlope < Strategy::ForcedSlope
	include Strategy

	HEAT_MAP_INC = 70.0

	def set_instance
		@goal_vecs = [
			Point.new(2.5, 2),
			Point.new(-2.5, -2),
			Point.new(-1, 3),
			Point.new(1, -3)
		]
		@heat_map = HeatMap.new(HEAT_MAP_INC)
	end

	def generate
		start_point_candidates = []
		20.times.each { start_point_candidates << @canvas.lines.sample.random_point }
		best_start_point = start_point_candidates.min{ |p| @heat_map.point_proximity_score(p) }

		candidate_lines = []
		max_length = rand * 600 + 100
		begin
			end_candidate = @canvas.lines.sample.random_point
			candidate_line = Line.new(best_start_point, end_candidate, 2, '#a00')
			candidate_lines << candidate_line if angle_within(candidate_line) && candidate_line.vector.magnitude < max_length
		end until candidate_lines.count >= 10

		new_line = candidate_lines.min{ |line| @heat_map.line_proximity_score(line) }

		@heat_map.add_line(new_line)
		new_line
	end
end