class Planet
  
  attr_reader :coords,:population,:ships
  
  def initialize(coords,population=rand(10)+1)
    @coords = coords
    @population = population
    @ships = []
    @goods = []
    @government_attributes = []
  end
  
  def tick
    
  end
  
  def land(ship)
    @ships << ship
  end
  
  def start(ship)
    @ships.delete ship
  end
  
  def shop
    
  end
  
end