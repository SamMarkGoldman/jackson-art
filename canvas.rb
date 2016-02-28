require './line.rb'
require './strategy/strategy.rb'

class Canvas
	attr_reader :lines, :width, :height

	def self.simple_grid(width, height, strategy)
		new(width, height, strategy).simple_grid
	end

	def self.perspective(width, height, strategy)
		new(width, height, strategy).perspective
	end

	def initialize(width, height, strategy)
		@width = width
		@height = height
		@lines = []
		@strategy = Strategy.create(strategy, self)
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
		increment = @width / 10
		generate_lines(11) { |n| Line.new(n*increment, 0, n*increment, @height, 3) }
	end

	def horizontal_lines
		increment = @height / 10
		generate_lines(11) { |n| Line.new(0, n*increment, @width, n*increment, 3) }
	end

	def narrowed_vertical_lines
		increment = @width / 10
		small_increment = @width / 30
		generate_lines(11) { |n| Line.new(@width / 3 + n*small_increment, 0, n*increment, @height, 4) }
	end

	def exponential_horizontal_lines
		increment = @height / 40
		generate_lines(11) { |n| Line.new(0, (n*increment)**1.35, @width, (n*increment)**1.35, 4) }
	end

	def generate_lines(n)
		n.times.each do |n|
			@lines << yield(n)
		end
	end

end