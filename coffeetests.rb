require 'rubygems'
require 'rspec'
require 'mycoffee'
require 'parslet/rig/rspec'


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
  end
  context "conditions" do
    it "number = -42 if opposite" do
        parser.if.should parse('number = -42 if opposite')
    end
  end
  context "verbatum" do
    it "passes everything without change" do
        parser.verbatum.should parse('%JS{ this is something that you ought to know }JS%')
    end
  end
  context "functions" do
    it "(x) -> x * x" do
        parser.function.should parse('(x) -> x * x')
    end
  end
end

RSpec::Core::Runner.run([])