require 'builder'
require 'pry'
require './canvas.rb'


# canvas = Canvas.simple_grid(700, 700, :forced_slope)
canvas = Canvas.perspective(700, 700, :forced_slope)
120.times.each do
	canvas.add_line
end


xml = Builder::XmlMarkup.new(:indent => 4)
xml.instruct!
xml.svg(width: canvas.width.to_s, height: canvas.height.to_s, xmlns: "http://www.w3.org/2000/svg", version: "1.1") {
	canvas.lines.each{ |line| line.render xml }
}



file = File.new("output.svg", "wb")
file.write(xml.target!)
file.close
