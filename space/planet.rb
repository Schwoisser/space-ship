class Planet
  
  attr_accessor :name, :population
  def initialize(name,population=rand(10)+1)
    @name = name
    @population = population
  end
end