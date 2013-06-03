class Planet
  
  attr_reader :coords,:population,:ships
  attr_accessor :goods
  
  def initialize(coords,population=rand(10)+1)
    @coords = coords
    @population = population
    @ships = []
    @goods = Goods.new()
    @government_attributes = []
    @production=[]
  end
  
  def tick
    
  end
  
  def land(ship)
    @ships << ship
  end
  
  def start(ship)
    @ships.delete ship
  end
  
  def buy(good)
    @goods.unload(good)
  end
  
  def sell(good)
    @goods.load(good)
  end

  
end