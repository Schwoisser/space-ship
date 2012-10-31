require "spec_helper"

describe Engine do
  
  before :each do
    @engine = Engine.new("TestEngine",10,10)
  end
  describe '#speed' do
    it "should be 10 by default" do
      @engine.speed.should == 10
    end
    
    it "should be 5 if damaged by 50%" do
      @engine.takesDamage 0.5
      @engine.speed.should == 5
    end
    
    it "should be 0 if off" do
      @engine.off
      @engine.speed.should == 0
    end    
  end
  
end