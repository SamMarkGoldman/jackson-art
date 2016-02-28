require './line.rb'

class SeedFactory
	def initialize(width, height)
		@width = width
		@height = height
	end

	def simple_grid
		seed = []
		vertical_lines seed
		horizontal_lines seed
		seed
	end

	def perspective
		seed = []
		exponential_horizontal_lines seed
		narrowed_vertical_lines seed
		seed
	end

	private

	def vertical_lines(lines)
		increment = @width / 10
		generate_lines(11, lines) { |n| Line.new(n*increment, 0, n*increment, @height) }
	end

	def horizontal_lines(lines)
		increment = @height / 10
		generate_lines(11, lines) { |n| Line.new(0, n*increment, @width, n*increment) }
	end

	def narrowed_vertical_lines lines
		increment = @width / 10
		small_increment = @width / 30
		generate_lines(11, lines) { |n| Line.new(@width / 3 + n*small_increment, 0, n*increment, @height) }
	end

	def exponential_horizontal_lines lines
		increment = @height / 40
		generate_lines(11, lines) { |n| Line.new(0, (n*increment)**1.35, @width, (n*increment)**1.35) }
	end

	def generate_lines(n, lines)
		n.times.each do |n|
			lines << yield(n)
		end
	end

end