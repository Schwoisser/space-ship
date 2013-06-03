require "spec_helper"


describe Goods do
  
  before :each do
    @goods = Goods.new
  end
  describe "#load" do
    it "should load it" do
      @goods.load(Good.new("test",5)).name.should == "test"
    end
  end
  describe "#unload" do
    it "should unload it" do
      @goods.load(Good.new("test",5))
      @goods.unload(Good.new("test",5)).name.should == "test"
    end
  end
end