class Ship
  attr_reader :name,:weoponMounts
  attr_accessor :hp,:engine,:generator,:shield,:weopons,:course,:radar,:coords
  
  def initialize(name,hp,weoponMounts,
    engine=false,generator=false,sensor=false,
    shield=false,weopons=false)
    
    @name,@hp,@weoponMounts = name,hp,weoponMounts
    #parts
    @engine,@generator,@sensor,@shield = engine,generator,sensor,shield
    
    #weopons array
    @weopons = []
    if weopons
      @weopons << weopons
    end
    
    
    
    @componentCommands = [:engine,:generator,:shield,:attack,:sensor,:plot]
    @shipCommands = [:report,:scan,:speed]
    @radar = []
    @course = false
    @coords = Coords.new(0,0,0)
  end
  
  def takeDamage(points)
    if @shield.shieldStatus > 0
      @shield.takeShieldDamage(points)
    else
      @hp -= points
    end
  end
  
  def attacks(ship)
    damage = 0
    @weopons.each do |w|
      damage += w.fire
    end
    ship.takeDamage(damage)
    damage
  end
  
  def regenerate
    if @shield
      @shield.regenerate
    end
    
    @weopons.each do |w|
      w.reload
    end
  end
  
  
  def command(args)
    com = args.first.intern
    if @shipCommands.include?(args.first.intern)
      method(args.first.intern).call
    elsif @componentCommands.include?(com)
    arg = args[1].intern
        case com
        when :engine
          if (@engine.respond_to? arg)
            @engine.method(arg).call
          end
        when :generator
          if (@generator.respond_to? arg)
            @generator.method(arg).call
          end
        when :shield
         if (@shield.respond_to? arg)
            @shield.method(arg).call
          end
        when :sensor
         if (@sensor.respond_to? arg)
            @sensor.method(arg).call
          end
        when :plot
          plot(args[1],args[2],args[3])
        when :attack
          attack(args[1])
        end
    end
  end
  
  def plot(x=0,y=0,z=0)
    puts"ploting new course"
    @course = Coords.new(x.to_i,y.to_i,z.to_i)
  end
  
  def sensorRange
    if @sensor
      @sensor.range
    else
      0
    end
  end
  
  def shieldStatus
    if @shield
      @shield.shieldStatus
    else
      0
    end
  end
  
  def speed
    if @engine
      @engine.speed
    else
      0
    end
  end
  
  def report
    @weopons.each do |w|
      w.report
    end
    @engine.report
    @generator.report
    @sensor.report
    @shield.report
    puts "HP : #{@hp}"
    puts "Position: #{@coords}"
    puts "Target: #{@course}"
    puts @radar
  end
  
  def scan
    if not @radar.empty?
      @radar.each do |blip|
        puts "Detected: "+blip.name+" HP/Shield: #{blip.hp} #{blip.shieldStatus}"+blip.coords.to_s
      end
    else
      puts "Only void."
    end
  end
  
  def attack(nr)
    nr = nr.to_i
    if @radar.size >= nr
      attacks(@radar[nr-1])
    end
  end
  
  def maneuver(name)
    case name[0]
    when "intercept"
    when "hold"
    when "evade"
  end
  
  def 
  
  def weopon(command)
  end

end