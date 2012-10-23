class Engine < Component
  def initialize(name,energyConsumption,speed)
    super(name,energyConsumption)
    @speed = speed
  end
  
  def speed
    @speed * efficency
  end
  
  def report
    status
    puts "Speed: #{speed}"
  end
  
end