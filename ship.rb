require "./space/planetary/goods"
require_relative "./space/coords"
require_relative "./space/planetary/planet"
require_relative "./space/planetary/goods"
class Ship
  attr_reader :name,:weoponMounts

  attr_accessor :capacity,:hp,:engine,:generator,:shield,:weopons,:course,:radar,:coords,:near_planet,:landed
                
  def initialize(name,hp,weoponMounts,
    engine=false,generator=false,sensor=false,
    shield=false,weopons=false, capacity = 10)
    
    @name,@hp,@weoponMounts,@capacity = name,hp,weoponMounts,capacity
    #parts
    @engine,@generator,@sensor,@shield = engine,generator,sensor,shield
    
    @goods = Goods.new(10)
    
    #weopons array
    @weopons = []
    if weopons
      @weopons << weopons
    end
    
    @componentCommands = [:engine,:generator,:shield,:attack,:sensor,:plot]
    @shipCommands = [:report,:scan,:speed]
    
    @radar = []
    @near_planet = false
    @landed = false
    @course = false
    
    @coords = Coords.new(0,0,0)
  end
  
  def load(good)
    @goods.load(good)
  end

  def unload(good)
    @goods.unload(good)
  end
  
  def sensor_signature
    1
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
          @engine.exec(arg)
        when :generator
          @generator.exec(arg)
        when :shield
          @shield.exec(arg)
        when :sensor
          @sensor.exec(arg)
        when :plot
          plot(args[1],args[2],args[3])
        when :attack
          attack(args[1])
        when :land
          land
        when :start
          start
        else
          "Unknown command"
        end
    end
  end
  
  def plot(x=0,y=0,z=0)
    @course = Coords.new(x.to_i,y.to_i,z.to_i)
    "ploting new course"
  end
  
  def sensorRange
    if @sensor
      @sensor.range
    else
      0
    end
  end
  

  def land
    if @near_planet && !@landed
      @near_planet.land(self)
      @landed = true
    else
      "No planet near."
    end
  end
  
  def start
    if @landed
      @near_planet.start(self)
      @landed = false
    else
      "Not landed."
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
    @engine.report +
    @generator.report +
    @sensor.report +
    @shield.report +
    "HP : #{@hp}" +
    " Position: #{@coords}" +
    " Target: #{@course}" + 
    "On radar: " +scan
  end
  
  def scan
    if not @radar.empty?
      @radar.each do |blip|
        "Detected: "+blip.name+" HP/Shield: #{blip.hp} #{blip.shieldStatus}"+blip.coords.to_s
      end
    else
      "Only void."
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
  end
  

  def weopon(command)
  end

end
