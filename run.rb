require 'builder'
require 'pry'
require './line.rb'

test_line = Line.new(40, 200, 120, 180)
initial_grid = []
11.times.each do |n|
	initial_grid << Line.new(n*50, 0, n*50, 500)
end
11.times.each do |n|
	initial_grid << Line.new(0, n*50, 500, n*50)
end

xml = Builder::XmlMarkup.new(:indent => 4)
xml.instruct!
xml.svg(width: "500", height: "500", xmlns: "http://www.w3.org/2000/svg", version: "1.1") {
	initial_grid.each{ |line| line.render xml }
	# test_line.render xml
}



file = File.new("output.svg", "wb")
file.write(xml.target!)
file.close
