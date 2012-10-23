require "spec_helper"

describe Planet do
  
  before :each do
    @planet = Planet.new("TestPlanet",args)
  end
  describe '#energyOutput' do
    it "should be 10 by default" do
      @generator.energyOutput.should == 10
    end
  end
  
end