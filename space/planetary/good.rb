class Good
  attr_accessor :name, :amount
  def initialize(name,amount)
    @name = name
    @amount = amount
  end
  
  def - (good)
    if @name == good.name
      @amount -= good.amount
    end
  end
end