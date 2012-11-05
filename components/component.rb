class Component
  attr_reader :name, :damage, :active
  def initialize(name,energyConsumption)
    @name,@energyConsumption = name,energyConsumption
    @damage = 0
    @crew=[]
    @active = true
    @commands = [:on,:off,:report]
  end
  
  def exec(command)
    if (@commands.include? command)
      self.method(command).call
    end
  end
  
  def energyConsumption
    if @active
      return @energyConsumption     
    else
      return 0
    end   
  end 
    
  
  def efficency
    if not @active
      return 0
    end
    #TODO complete
    1.0 - @damage
  end
  
  def on
    @active = true
  end
  
  def off
    @active = false
  end
  
  def takesDamage(points)
    @damage +=points
    if @damage > 1.0
      @damage = 1.0
    end
  end
  
  def repair(points)
    @damage -=points
    
    if @damage < 0
      @damage = 0
    end
  end
  
  def selfRepair
    
  end
  
  def status
    puts @name
    puts "Damage: #{@damage}"
    puts "Active: #{@active}"
  end
  
  def report
    status
  end
  
end