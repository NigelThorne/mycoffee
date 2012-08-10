require 'rspec'
require 'parslet/rig/rspec'

require 'myjsparser'

describe ComplexParser  do
  let(:parser) { ComplexParser.new }
  context "simple_rule" do
    it "should consume 'a'" do
      parser.simple_rule.should parse('a')
    end 
  end
end

RSpec::Core::Runner.run([])