require "spec_helper"

#Ship integration test
describe Ship do
  
  before :each do
    @engine    = Engine.new("TestEngine",1,1)
    @generator = Generator.new("TestGenerator",6)
    @sensor    = Sensor.new("TestSensor",1,1)
    @shield    = Shield.new("TestShield",1,20,1)
    @weopon    = Weopon.new("TestWeopon",1,1,1,1)
    
    @ship      = Ship.new("name",20,2,@engine,@generator,@sensor,@shield,@weopon)
    
    @engine    = Engine.new("TestEngine",1,1)
    @generator = Generator.new("TestGenerator",6)
    @sensor    = Sensor.new("TestSensor",1,1)
    @shield    = Shield.new("TestShield",1,20,1)
    @weopon    = Weopon.new("TestWeopon",1,1,1,1)
    
    @enemy     = Ship.new("enemy",20,2,@engine,@generator,@sensor,@shield,@weopon)
  end
  describe '#takeDamage' do
    it "should one hit shouldn't destroy the ships shields" do
      @ship.takeDamage(50)
      @ship.hp.should==20
    end
    it "should be damaged after two heavy hits" do
      @ship.takeDamage(20)
      @ship.takeDamage(20)
      @ship.hp.should==0
    end
    it "should be damaged after two heavy hits" do
      @ship.takeDamage(1)
      @ship.takeDamage(1)
      @ship.shieldStatus.should==18
    end
  end
  
  describe '#attack' do
    it "should only hit once and then reload" do
      @ship.attacks(@enemy).should == 1 
      @enemy.shieldStatus.should == 19
      @ship.attacks(@enemy)== 0
      @enemy.shieldStatus.should == 19
      @ship.regenerate
      @ship.attacks(@enemy).should == 1
      @enemy.shieldStatus.should == 18
    end
    it "should reload after one reg" do
      @ship.attacks(@enemy).should == 1
      @ship.regenerate
      @ship.attacks(@enemy).should == 1
      @enemy.shieldStatus.should == 18
    end
  end  
  
  describe '#regenerate' do
    it "should regenerate the shield" do
      @ship.takeDamage(19)
      @ship.regenerate
      @ship.shieldStatus.should == 2
    end
    it "should reload the weopon" do
      @ship.weopons[0].fire.should == 1
      @ship.weopons[0].fire.should == 0
      @ship.regenerate
      @ship.weopons[0].fire.should == 1
    end
  end
  
  describe "#sensorRange" do
    it "should return the sensor range" do
      @ship.sensorRange.should == 1
    end
  end
  
  describe "#shieldStatus" do
    it "should return the sensor range" do
      @ship.shieldStatus.should == 20
    end
  end
  
  describe "#speed" do
    it "should return the sensor range" do
      @ship.speed.should == 1
    end
  end
  
  describe "#load" do
    
  end
  
  describe "#command" do
    it "should deactivate the shield" do
      @ship.command(["shield","off"])
      @ship.shieldStatus.should == 0
    end
    it "should deactivate the shield" do
      @ship.command(["shield","on"])
      @ship.shieldStatus.should == 20
    end
    it "should deactivate the engine" do
      @ship.command(["engine","off"])
      @ship.speed.should == 0
    end
    it "should deactivate the generator" do
      @ship.command(["generator","off"])
      @ship.generator.energyOutput.should == 0
    end
    it "should deactivate the sensor" do
      @ship.command(["sensor","off"])
      @ship.sensorRange.should == 0
    end
    it "should attack the target" do
      @ship.radar = [@enemy]
      @ship.command(["attack","1"])
      @enemy.shieldStatus == 19
    end
    it "should reloading should work" do
      @ship.radar = [@enemy]
      @ship.command(["attack","1"])
      @enemy.shieldStatus == 19
      @ship.command(["attack","1"])
      @enemy.shieldStatus == 19
      @ship.regenerate
      @ship.command(["attack","1"])
      @enemy.shieldStatus == 18
    end
    it "should plot anew course" do
      @ship.command(["plot","5","5","5"])
      @ship.course.x.should == 5
    end    
    it "should yust work" do
      @ship.command(["report"])
    end
  end
end