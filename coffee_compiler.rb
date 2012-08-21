
require 'rubygems'
require 'parslet'
require 'parslet/convenience'

# take a file
# read it
# generate javascript verbatum

require './js_transform'
require './coffee_parser'


class MyCoffeeCompiler
	def initialize
		@parser =  CoffeeParser.new 
		@transform = JsTransform.new
	end
	
	def compile(source)
		parsed = @parser.parse_with_debug(source)		
		transformed = @transform.apply(parsed) 
	end
end

if __FILE__ == $0  && ARGV[0]!=nil
	compiler = MyCoffeeCompiler.new

	input = File.read(ARGV[0])
	output = compiler.compile(input)

	if(ARGV[1]==nil)
		puts "***OUTPUT***"
		puts output.inspect
	else
		f = File.new(ARGV[1], "w")
		f.write(output)     
		f.close
	end
end