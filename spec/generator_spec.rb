require "spec_helper"

describe Generator do
  
  before :each do
    @generator = Generator.new("TestGenerator",10)
  end
  describe '#energyOutput' do
    it "should be 10 by default" do
      @generator.energyOutput.should == 10
    end
    
    it "should be 5 if damaged by 50%" do
      @generator.takesDamage 0.5
      @generator.energyOutput.should == 5
    end
    
    it "should be 0 if off" do
      @generator.off
      @generator.energyOutput.should == 0
    end
  end
  
end