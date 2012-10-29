require "spec_helper"

describe Planet do
  
  before :each do
    @planet = Planet.new("TestPlanet")
  end
  describe '#name' do
    it "should return its name" do
      @planet.name.should == "TestPlanet"
    end
    
  end
  
end