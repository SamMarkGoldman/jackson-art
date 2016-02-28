class Point
	attr_accessor :x, :y

	def initialize(x, y)
		@x = x
		@y = y
	end

	def +(other)
		Point.new(@x + other.x, @y + other.y)
	end

	def -(other)
		Point.new(@x - other.x, @y - other.y)
	end

	def *(number)
		Point.new(@x * number, @y * number)
	end

	def /(number)
		Point.new(@x / number, @y / number)
	end

	def magnitude
		Math.sqrt(@x**2 + @y**2)
	end

	def unit
		self / magnitude
	end 

    def to_s
        "(#{@x}, #{@y})"
    end

end