class Generator < Component
  def initialize(name,energyOutput)
    super(name,0)
    @energyOutput = energyOutput
  end
  
  def energyOutput
    @energyOutput * efficency
  end
  
  def report
    status
    puts "Energy output: #{energyOutput}"
  end
end