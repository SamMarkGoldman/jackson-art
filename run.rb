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
	max_length: 155..250
})
canvas.set_strategy strat
NUMBER_LINES = 330
NUMBER_LINES.times.each do |n|
  red_value = (128 * n.to_f / NUMBER_LINES + 90).to_i.to_s(16)
  green_value = (-100 * n.to_f / NUMBER_LINES + 120).to_i.to_s(16)
  color = "##{red_value}#{green_value}00"
	canvas.add_line(color)
end

strat = Strategy.create(:sparce_slope, {
	goals: [ Point.new(2.5, 0) ],
	color: '#a00',
	max_length: 80..150
})
canvas.set_strategy strat
# NUMBER_LINES = 280
(NUMBER_LINES/2).times.each do |n|
  red_value = (128 * n.to_f / NUMBER_LINES + 90).to_i.to_s(16)
  green_value = (-100 * n.to_f / NUMBER_LINES + 120).to_i.to_s(16)
  color = "#0000#{green_value}"
	canvas.add_line(color)
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
