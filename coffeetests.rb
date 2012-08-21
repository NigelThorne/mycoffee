require 'rubygems'
require 'rspec'
require 'mycoffee'
require 'parslet/rig/rspec'

describe MyCoffeeCompiler


describe CoffeeParser  do
  let(:parser) { CoffeeParser.new }
  context "comments" do
    it("should parse comments") do
      parser.comment.should parse("# anything after a hash")
    end
    it("should not parse anything past the end of line") do
      parser.comment.should_not parse("# anything after a hash\n something")
    end
  end
  context "identifier" do
    it "bob works" do
      parser.identifier.should parse('bob')
    end 
    it "jane21 works" do
      parser.identifier.should parse('jane21')
    end 
    it "22 does not work" do
      parser.identifier.should_not parse('22')
    end 
    it "Jane does not work" do
      parser.identifier.should_not parse('Jane')
    end 
  end
  context "number" do
    it "42" do
      parser.number.should parse('42')
    end 
    it "4.2" do
      parser.number.should parse('4.2')
    end 
  end
  context "assignment" do
    it "number = 42" do
      parser.assignment.should parse('number = 42')
    end 
    it "opposite = true" do
      parser.assignment.should parse('opposite = true')
    end 
    it "something = (x) -> x * x" do
      parser.assignment.should parse('something = (x) -> x * x')
    end 
    it "list = [1, 2, 3, 4, 5]" do
      parser.assignment.should parse('list = [1, 2, 3, 4, 5]')
    end 
  end
  context "conditions" do
    it "number = -42 if opposite" do
        parser.if.should parse('number = -42 if opposite')
    end
  end
  context "verbatum" do
    it "passes everything without change" do
        parser.verbatum.should parse('` this is something that you ought to know `')
    end
  end
  context "functions" do
    it "lambdas" do
        parser.function.should parse('(x) -> x * x')
    end
    it "static methods" do
        parser.function.should parse('Math.sqrt')
    end
    it "splat" do
        parser.function.should parse('(winner, runners...) -> print(winner, runners)')
    end
  end
  context "function_calls" do
    it "simple" do
        parser.function_call.should parse('print(x)')
    end
    it "simple2" do
        parser.function_call.should parse("square(x)\n")
    end
  end
  context "array" do 
    it "[1,2,3]" do 
        parser.array.should parse("[1,2,3]")
    end
    it "[  a, b , c  ]" do 
        parser.array.should parse("[  a, b , c  ]")
    end
  end
  context "parameter_list" do 
    it "simple" do 
        parser.parameter_list.should parse("a,b,c")
    end
    it "splats" do 
        parser.parameter_list.should parse("a,b,c...")
    end
  end
  context "object" do
    it "{
      root:   Math.sqrt,
      square: square,
      cube:   (x) -> x * square(x),
      }" do
      parser.object.should parse("{\nroot:   Math.sqrt\n}")
      parser.object.should parse("{\nsquare: square\n}")
      parser.object.should parse("{\ncube:   (x) -> x * square(x)\n}")
      parser.object.should parse("{\nroot:   Math.sqrt,\nsquare: square\n}")
      parser.object.should parse("{\nroot:   Math.sqrt,\nsquare: square,\ncube:   (x) -> x * square(x)\n}")
    end
  end
end

RSpec::Core::Runner.run([])