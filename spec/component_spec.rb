require "spec_helper"

describe Component do
  before :each do
    @component = Component.new("TestComponent",10)
  end
  describe '#new' do
    it "should return a generic component with the given values" do
      @component.should be_an_instance_of Component
      @component.name.should == "TestComponent"
    end
  end
  
  describe '#energyConsumption' do
    it 'should be 10 when active' do
      @component.energyConsumption.should == 10
    end
    
    it 'should be 0 when inactive' do
      @component.off
      @component.energyConsumption.should == 0
    end    
  end
  
  describe '#efficency' do
    it 'should be 100% ehh 1.0 when undamaged and active' do
      @component.efficency.should == 1.0
    end
    
    it 'should be 0% when inactive' do
      @component.off
      @component.efficency.should == 0
    end 
    
    it 'should be 50% when when damaged by 50%' do
      @component.takesDamage(0.5)
      @component.efficency.should == 0.5
    end       
  end
  
  describe '#takesDamage' do
    it 'should be undamaged by default' do
      @component.damage.should == 0
    end
    
    it 'should be damaged if damaged'do
      @component.takesDamage(0.3)
      @component.damage.should == 0.3
    end
  end
  
  describe '#repair' do
    it 'should only repair to 0% damage' do
      @component.repair(1).should == 0
    end
    
  end
  
end