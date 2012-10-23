require "spec_helper"

#Ship integration test
describe Ship do
  
  before :each do
    @engine    = Engine.new("TestEngine",1,1)
    @generator = Generator.new("TestGenerator",6)
    @sensor    = Sensor.new("TestSensor",1,10)
    @shield    = Shield.new("TestShield",1,20,1)
    @weopon    = Weopon.new("TestWeopon",1,1,1,1)
    
    @ship      = Ship.new("name",20,2,@engine,@generator,@sensor,@shield,@weopon)
    
    @engine    = Engine.new("TestEngine",1,1)
    @generator = Generator.new("TestGenerator",6)
    @sensor    = Sensor.new("TestSensor",1,10)
    @shield    = Shield.new("TestShield",1,20,1)
    @weopon    = Weopon.new("TestWeopon",1,1,1,1)
    
    @enemy     = Ship.new("enemy",20,2,@engine,@generator,@sensor,@shield,@weopon)
    
    @space = Space.new
  end
  
  describe "#addShip" do
    it "should add ship to @ships" do
      @space.addShip(1,1,1,@ship)
      @space.ships.first.should === @ship
      @ship.coords.x.should == 1
    end
  end
  
  describe "#addAIShip" do
    it "should add an ai ship to both the ships list and the ai list" do
      @space.addAIShip(1,1,1,@enemy)
      @space.ships.first.should === @enemy
      @space.ai.first.should === @enemy
      @enemy.coords.x.should == 1
    end
  end
  
  describe "#find" do
    it "should find the given ship if there and return it" do
      @space.find(@ship).should == false
      @space.addShip(1,1,1,@ship)
      @space.find(@ship).should == true
    end
  end
  
  describe "#moveShips" do
    it "should move all ships nearer to there course if set" do
      @space.addShip(1,1,1,@ship)
      @space.addAIShip(2,2,2,@enemy)
      @ship.plot(50,50,50)
      puts @space.ships
      @space.moveShips
      @ship.coords.x.should > 1
      @enemy.coords.x.should == 2
    end
  end
  
  describe "#regenerateShips" do
    it "should regenerate all ships" do
      @space.addShip(1,1,1,@ship)
      @ship.takeDamage(1)
      @space.regenerateShips
      @ship.shieldStatus.should == 20
    end
    
  end
  
  describe "#aiCommands" do
    it "should make the ai attack the radar target" do
      @space.addShip(1,1,1,@ship)
      @space.addAIShip(2,2,2,@enemy)
      @enemy.radar << @ship
      @space.aiCommands
      @ship.shieldStatus.should == 19
    end
    
  end
  
  describe "#clear" do
    it "should clear all dead ships for the garbage collection" do
      @space.addAIShip(2,2,2,@enemy)
      @enemy.hp = 0
      @space.clear
      @space.ships.empty?.should == true
      @space.ai.empty?.should == true
    end
  end
  
  describe "#createEncounter" do
    it "should create an encounter at some point" do
      
      while @space.createEncounter == false
      end
      @space.ai.first.name.should == "Raider"
    end
  end
  
  describe "#generateEnemy" do
    it "should create an enemy" do
      enemy = @space.generateEnemy
      enemy.name.should == "Raider"
    end
  end
  
  describe "#areaScan" do
    it "should add nearby ships to the radar off a ship" do
      @space.addShip(1,1,1,@ship)
      @space.addAIShip(2,2,2,@enemy)
      
      @space.areaScan(@ship)
      @ship.radar.include?(@enemy).should == true
    end
    
    it "should not found ships too far away" do
      @space.addShip(1,1,1,@ship)
      @space.addAIShip(20,2,2,@enemy)
      
      @space.areaScan(@ship)
      @ship.radar.include?(@enemy).should == false
    end
    
  end

end