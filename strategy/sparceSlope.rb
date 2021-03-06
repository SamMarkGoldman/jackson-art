require_relative './helper.rb'

class Strategy::SparceSlope < Strategy::ForcedSlope
	include Strategy

	HEAT_MAP_INC = 40.0

	def set_instance(args)

		@goal_vecs = []
		args[:goals].each do |goal|
			@goal_vecs << goal
			@goal_vecs << goal * -1
		end
		# @color = args[:color] ? args[:color] : :black
		@max_length = args[:max_length] ? args[:max_length] : 1000..1000
		
		@heat_map = HeatMap.new(HEAT_MAP_INC)
	end

	def canvas=(c)
		@canvas = c
		@heat_map.canvas = c
	end

	def generate(stroke_color = :black)
		start_point_candidates = []
		50.times.each { start_point_candidates << @canvas.lines.sample.random_point }
		start_point_candidates.sort_by!{ |p| @heat_map.point_proximity_score(p) }

		candidate_lines = []
		max_length = rand * @max_length.max + @max_length.min
		Strategy::Helper.unique_pairs(start_point_candidates[0, 7]).each do |pair|
			candidate_line = Line.new(pair[0], pair[1], 2, stroke_color)
			candidate_lines << candidate_line if angle_within(candidate_line) && candidate_line.magnitude < max_length
		end

		raise StandardError if candidate_lines.count == 0
		new_line = candidate_lines.min{ |line| @heat_map.line_proximity_score(line) }

		@heat_map.add_line(new_line)
		new_line
	end
end