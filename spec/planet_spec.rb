require "spec_helper"

describe Planet do
  
  before :each do
    @planet = Planet.new("TestPlanet")
    @engine    = Engine.new("TestEngine",1,1)
    @generator = Generator.new("TestGenerator",6)
    @sensor    = Sensor.new("TestSensor",1,1)
    @shield    = Shield.new("TestShield",1,20,1)
    @weopon    = Weopon.new("TestWeopon",1,1,1,1)
    
    @ship      = Ship.new("name",20,2,@engine,@generator,@sensor,@shield,@weopon)    
  end
  describe '#land' do
    it "should land a ship" do
      @planet.land @ship
      @planet.ships.include?(@ship).should == true
      @planet.start @ship
    end
  end
  describe '#buy' do
    it "should buy and load a good" do
     @planet.sell Good.new("test",2)
     puts @planet.goods
     g = @planet.buy(Good.new("test",1))
    end
  end
  
  describe '#sell' do
    it "should sell and unload a good" do
      
    end    
  end
  
  describe '#buy' do
    it "should buy the goods and load them to the ship" do
      
    end
  end
  
end