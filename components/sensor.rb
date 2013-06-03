class Sensor < Component
  def initialize(name,energyConsumption,range)
    super(name,energyConsumption)
    @range = range
  end
  
  def range
    @range * efficency
  end
  
  def report
    status + "Range: #{range}"
  end  
end