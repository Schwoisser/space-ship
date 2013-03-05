class Citizen
  attr_accessor 
  def initialize(homeplanet)
    @homeplanet = homeplanet
    @motivation = 1.0
    @health = 1.0
  end
  
  def productivity()
    (@health + @motivation)/2.0
  end
  
  def tick()
    
  end
  
  def buy()
    
  end
  
  def produce()
    
  end
  
  def sell()
    
  end
  
end