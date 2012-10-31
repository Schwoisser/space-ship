require "spec_helper"

describe Weopon do
  
  before :each do
    @weopon = Weopon.new("TestEngine",1,1,1,1)
  end
  describe '#fire' do
    it "should be 1 by default" do
      @weopon.fire.should == 1
    end
    
    it "should be 0.5 if damages" do
      @weopon.takesDamage 0.5
      @weopon.fire.should == 0.5
    end
    
    it "should be in between the parameters"  do
      @weopon = Weopon.new("TestEngine",1,1,10,1)
      @weopon.fire.should <= 10
      @weopon.reload
      @weopon.fire.should >= 0
    end
  end
  describe "#reload" do
    it "should only fire once and then reload to fire again" do
      @weopon.fire.should == 1
      @weopon.fire.should == 0
      @weopon.reload
      @weopon.fire.should == 1
    end
  end
  
end