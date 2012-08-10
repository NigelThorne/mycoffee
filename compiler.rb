require 'rubygems'
require 'parslet'

# take a file
# read it
# generate javascript verbatum

require './myjsparser'

parser =  MyJSParser.new 
input = (File.read("in.my"))

require 'parslet/convenience'
output = parser.parse_with_debug(input)

puts output.inspect


class MyTransform < Parslet::Transform
    rule(:js => simple(:inline))           				{ inline   }
    rule(:int => simple(:val))             				{ val.to_i }
    rule(:loop => {:times => simple(:reps), :body => simple(:body) })             { (0..reps).map{ body }.join("\n") }
end


output = MyTransform.new.apply(output) 

puts "***OUTPUT***"
puts output.inspect

f = File.new("out.js", "w")
f.write(output)     
f.close

