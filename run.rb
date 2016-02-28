require 'builder'
require 'pry'
require './seedFactory.rb'


initial_grid = SeedFactory.new(500, 500).perspective

xml = Builder::XmlMarkup.new(:indent => 4)
xml.instruct!
xml.svg(width: "500", height: "500", xmlns: "http://www.w3.org/2000/svg", version: "1.1") {
	initial_grid.each{ |line| line.render xml }
	# test_line.render xml
}



file = File.new("output.svg", "wb")
file.write(xml.target!)
file.close
