class HeatMap
	def initialize(inc)
		@inc = inc
		@map_points = []
	end

	def add_line(line)
		@map_points.concat line_points(line)
		@map_points.sort_by!(&:x)
	end

	def line_proximity_score(line)
		line_points(line).reduce(0) do |cost, point|
			cost += point_proximity_score(point)
			cost
		end
	end

	def point_proximity_score(point)
		search_r = @inc * 5
		s = slice(point.x - search_r, point.x + search_r)
		score = slice(point.x - search_r, point.x + search_r).reduce(0) do |cost, map_point|
			distance = (map_point - point).magnitude
			cost += (search_r - distance)**2 if distance < search_r
			cost
		end
		score == nil ? 0 : score
	end

	private

	def slice(x1, x2)
		start = nil
		length = 0
		counter = 0
		start = 0 if @map_points.count > 0 && @map_points[0].x > x1
		@map_points.each do |p|
			start = counter if !start && p.x > x1
			length += 1 if start
			break if start && p.x > x2
			counter += 1
		end
		return @map_points[start, length] if start
		return []
	end

	def line_points(line)
		inc_line = line.vector.unit * @inc
		point = line.end1
		points = []
		while (point - line.end1).magnitude <= (line.end2 - line.end1).magnitude
			points << point
			point += inc_line
		end
		points
	end
end