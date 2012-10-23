class Shield < Component
  def initialize(name,energyConsumption,shield,regenerationRate)
    super(name,energyConsumption)
    @shield,@regenerationRate = shield,regenerationRate
    @curShield = shield
    @offTime = 0
  end
  
  def shieldStatus
    @curShield * efficency
  end
  
  def takeShieldDamage(points)
    @curShield -= points
    if @curShield <= 0
      @curShield = 0
      @offTime = 5
    end
  end
  
  def regenerate
    if @active
      
      if @offTime > 0
        @offTime -= 1
        return
      end
      
      @curShield += @regenerationRate
      if @curShield > @shield
        @curShield = @shield
      end    
    end
  end
  
  def report
    status
    puts "Shield: #{shieldStatus}"
  end
  
end