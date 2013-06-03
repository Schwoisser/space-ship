class Space
  attr_accessor :thread, :ships, :ai
  def initialize()
    @ships= []
    @ai = []
    @stop = false
    @thread = startThread
    @planets = generate_planets
  end
  
  def generate_planets()
    
  end
  
  def startThread
    Thread.new{
      while not @stop
        sleep(5)
        puts "ping"
        moveShips
        aiCommands
        createEncounter
        clear
        updateRadar
      end
    }
  end
  
  def addShip(x,y,z,ship)
    ship.coords = Coords.new(x,y,z)
    @ships << ship
  end
  
  def addAIShip(x,y,z,ship)
    addShip(x,y,z,ship)
    @ai << ship
    puts "ship added"
    @ai.each do |ai|
      puts ai.name
    end
    
  end
  
  def find_player(name)
    @ships.each do |ship|
      if ship.name == name
        return ship
      end
    end
    return nil
  end

  
  def find(ship)  
    @ships.include? ship
  end
  
  def moveShips
    @ships.each do |ship|
      if ship.course
        ship.coords.moveTo(ship.course,ship.speed)
      end
    end
  end   
  
  def regenerateShips
    @ships.each do |ship|
      ship.regenerate
    end
  end
  
  def updateRadar
    @ships.each do |ship|
      areaScan(ship)
    end
  end
  
  def aiCommands
    @ai.each do |ai|
      if not ai.radar.empty?
        ai.attacks(ai.radar.first)
      end
    end
  end
  
  def clear
    @ships.each do |ship|
      if ship.hp <= 0
        @ships.delete(ship)
        @ai.delete(ship)
      end
    end
  end
  
  def createEncounter
    if (rand(6)+1) >= 5 && @ai < 20
      addAIShip(rand(100),rand(100),rand(100),generateEnemy)
      return true
    else
      false
    end
  end
  
  def generateEnemy
    engine = Engine.new("Mass Drive",5,5)
    generator = Generator.new("Mass gen",5)
    sensor = Sensor.new("TestSensor",10,10)
    shield = Shield.new("Shield 3",5,rand(50),5)
    weopons = Weopon.new("Mass Driver",5,5,5,5)
    
    return Ship.new("Raider",rand(100),1,engine,generator,sensor,shield,weopons)

  end
  
  def areaScan(ship)
    sensorRange = ship.sensorRange
    others = @ships - [ship]
    found = []
    
    if (others.size > 0)
      others.each do |otherShip|
          if (ship.coords.distanceTo(otherShip.coords)) < sensorRange
            found << otherShip
          end
      end
    end
    ship.radar = found
  end
end