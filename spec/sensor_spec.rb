require "spec_helper"

describe Sensor do
  
  before :each do
    @sensor = Sensor.new("TestSensor",10,10)
  end
  describe '#range' do
    it "should be 10 by default" do
      @sensor.range.should == 10
    end
    
    it "should be 5 if damaged by 50%" do
      @sensor.takesDamage 0.5
      @sensor.range.should == 5
    end
    
    it "should be 0 if off" do
      @sensor.off
      @sensor.range.should == 0
    end    
  end
  
end