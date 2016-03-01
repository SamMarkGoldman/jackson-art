require 'builder'
require 'pry'
require './canvas.rb'


# Point.new(2.5, 2),
# Point.new(-1, 3),

canvas = Canvas.simple_grid(700, 700)
# canvas.set_strategy Strategy.create(:forced_slope)
# 60.times.each do
# 	canvas.add_line
# end

# make sure the heat map is reusable

strat = Strategy.create(:sparce_slope, {
	goals: [ Point.new(2.5, 2), Point.new(-1, 3) ],
	color: '#a00',
	max_length: 700..700
})
canvas.set_strategy strat
80.times.each do
	canvas.add_line
end

# canvas.set_strategy Strategy.create(:sparce_slope, {
# 	goals: [ Point.new(1, 0), Point.new(0, 3) ],
# 	color: '#60b',
# 	max_length: 60..150
# })
# 60.times.each do
# 	canvas.add_line
# end

xml = Builder::XmlMarkup.new(:indent => 4)
xml.instruct!
xml.svg(width: canvas.width.to_s, height: canvas.height.to_s, xmlns: "http://www.w3.org/2000/svg", version: "1.1") {
	canvas.lines.each{ |line| line.render xml }
}



file = File.new("output.svg", "wb")
file.write(xml.target!)
file.close

binding.pry
a = 0