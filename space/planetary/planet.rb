class Planet
  
  attr_reader :coords,:population,:ships
  
  def initialize(coords,population=rand(10)+1)
    @coords = coords
    @population = population
    @ships = []
    @goods = []
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
    goods.each do |g|
      if g.name == good.name && g.amount >= good.amount
        g.amount -= good.amount
        
        if g.amount == 0
          goods.delete g
        end
        return true
      end
    end
    return false
  end
  
  def sell(good)
        if free_capacity >= good.amount
      goods << good
      true
    else
      false
    end
  end

  
end