require './point.rb'

class Line
	module Colors
		ALL = [
			:black,
			:blue,
			:red
		]
	end

	attr_accessor :end1, :end2

	def initialize(p1, p2, width = nil, stroke = :black)
		@end1 = p1
		@end2 = p2
		@stroke = stroke
		width ? @width = width : @width = 2
	end

	def render(xml)
		xml.line(
			x1: @end1.x.to_s, 
			x2: @end2.x.to_s,
			y1: @end1.y.to_s, 
			y2: @end2.y.to_s, 
			stroke: @stroke.to_s, 
			"stroke-width" => @width.to_s
		)
	end	

	def to_s
		"#{end1}, #{end2}"
	end

	def random_point(increments = nil)
		end1 + vector * random_value(increments)
	end

	def magnitude
		vector.magnitude
	end

	def vector
		@vector ||= end2 - end1
	end

	private 

	def random_value(increments = nil)
		if increments
			((rand * (increments + 1)).round) / increments.to_f
		else
			rand
		end
	end
end
