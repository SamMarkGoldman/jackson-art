require_relative '../line.rb'
require_relative './heatMap.rb'

module Strategy

	attr_writer :canvas

	def self.create(type)
		case type
			when :forced_slope
				return Strategy::ForcedSlope.new
			when :sparce_slope
				return Strategy::SparceSlope.new
		end
	end

	def initialize
		set_instance if respond_to? :set_instance
	end

	def random_line(increments = nil)
		line_a = @canvas.lines.sample
		begin 
			line_b = @canvas.lines.sample 
		end until line_b != line_a
		start_point = line_a.random_point(increments)
		end_point = line_b.random_point(increments)
		Line.new(start_point, end_point)
	end
end

require_relative './forcedSlope.rb'
require_relative './sparceSlope.rb'
