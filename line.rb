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

	def initialize(x1, y1, x2, y2)
		@end1 = Point.new(x1, y1)
		@end2 = Point.new(x2, y2)
		@stroke = :black
		@width = 5
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
end