require './line.rb'
require './strategy/strategy.rb'

class Canvas
	attr_reader :lines, :width, :height

	def self.simple_grid(width, height)
		new(width, height).simple_grid
	end

	def self.perspective(width, height)
		new(width, height).perspective
	end

	def initialize(width, height)
		@width = width
		@height = height
		@lines = []
	end

	def set_strategy(strategy)
		@strategy = strategy
		strategy.canvas = self
	end

	def simple_grid
		vertical_lines
		horizontal_lines
		self
	end

	def perspective
		exponential_horizontal_lines
		narrowed_vertical_lines
		self
	end

	def add_line
		@lines << @strategy.generate
	end

	private

	def vertical_lines
		increment = @width / 5
		generate_lines(6) { |n| Line.new(Point.new(n*increment, 0), Point.new(n*increment, @height), 3) }
	end

	def horizontal_lines
		increment = @height / 5
		generate_lines(6) { |n| Line.new(Point.new(0, n*increment), Point.new(@width, n*increment), 3) }
	end

	def narrowed_vertical_lines
		increment = @width / 10
		small_increment = @width / 30
		generate_lines(11) { |n| Line.new(Point.new(@width / 3 + n*small_increment, 0), Point.new(n*increment, @height), 4) }
	end

	def exponential_horizontal_lines
		increment = @height / 120
		generate_lines(11) { |n| Line.new(Point.new(0, (n*increment)**1.75), Point.new(@width, (n*increment)**1.75), 4) }
	end

	def generate_lines(n)
		n.times.each do |n|
			@lines << yield(n)
		end
	end

end