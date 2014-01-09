require "./components/component"
require "./components/engine"
require "./components/generator"
require "./components/shield"
require "./components/weopon"
require "./components/sensor"
require "./ship"
require "./space/coords"
require "./space"

class Command
  def initialize(ship)
    @playerShip = ship
  end
  
  def help
    puts "Command not Found"
  end
  
  def gameLoop
    @space = Space.new
    @space.addShip(0,0,0,@playerShip)
    @space.startThread
    system('clear')
    while line=gets.chomp do
      @playerShip.command(line.split)
      if @playerShip.hp <= 0
        puts "You have been destroyed."
        return
      end
    end
  end
  
end

engine = Engine.new("Mass Drive",5,5)
generator = Generator.new("Mass gen",5)
shield = Shield.new("Shield 3",5,50,5)
weopons = Weopon.new("Mass Driver",5,5,5,5)
sensor = Sensor.new("TestSensor",10,100)

ship = Ship.new("Name",100,1,engine,generator,sensor,shield,weopons)

com = Command.new(ship)
com.gameLoop
