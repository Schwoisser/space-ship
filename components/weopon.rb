class Weopon < Component
  def initialize(name,energyConsumption,damageMin,damageDice,precision)
    super(name,energyConsumption)
    @damageMin,@damageDice,@precision = damageMin,damageDice,precision
    @loaded = true
  end
  
  def fire
    if @loaded
      @loaded = false
      return (rand(@damageDice)+@damageMin) * efficency
    else
      puts "Weopon not loaded"
      return 0
    end
  end
  
  def reload
    @loaded = true
  end
  
  def precision
    @precision
  end
  
  def report
    status
    puts "Loaded: #{@loaded}"
  end
end