class Coords
  attr_accessor :x,:y,:z
  def initialize(x,y,z)
    @x,@y,@z = x,y,z
  end
  
  def copyIn(b)
    @x = b.x
    @y = b.y
    @z = b.z
    self
  end
  
  def distanceTo(b)
    Math.sqrt((@x-b.x)*(@x-b.x) + (@y-b.y)*(@y-b.y) + (@z-b.z)*(@z-b.z))
  end
  
  def moveTo(targetCoords,speed)
    #c = b - a
    x = targetCoords.x - @x
    y = targetCoords.y - @y
    z = targetCoords.z - @z
    
    dist = distanceTo(targetCoords)
    
    if (dist > speed)
      factor = speed / dist
      x *= factor 
      y *= factor 
      z *= factor 
      @x += x
      @y += y
      @z += z
      return false
    else
      #Target reached
      copyIn(targetCoords)
      return true
    end
   end
   def to_s
     "x: #{@x} y: #{@y} z: #{@z}"
   end
end
