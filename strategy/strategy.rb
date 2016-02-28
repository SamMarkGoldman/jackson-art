require_relative '../line.rb'

module Strategy
	def self.create(type, canvas)
		case type
			when :forced_slope
				return Strategy::ForcedSlope.new(canvas)
		end
	end

	def initialize(canvas)
		@canvas = canvas
		set_instance if respond_to? :set_instance
	end

	def random_line
		line_a = @canvas.lines.sample
		begin 
			line_b = @canvas.lines.sample 
		end until line_b != line_a
		start_point = line_a.random_point
		end_point = line_b.random_point
		Line.new(start_point.x, start_point.y, end_point.x, end_point.y)
	end
end

require_relative './forcedSlope.rb'
