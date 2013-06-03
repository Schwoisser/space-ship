class Goods
  def initialize(capacity=10000000,goods=[])
    @capacity = capacity
    @goods=goods
  end

  def load(good)
    if free_capacity >= good.amount
      @goods << good
      return good
    else
      false
    end
  end
  
  def unload(good)
    @goods.each do |g|
      if g.name == good.name && g.amount >= good.amount
        g.amount -= good.amount
        if g.amount == 0
          @goods.delete g
        end
        return good
      end
    end
    return false
  end
  
  def free_capacity
    cap = @capacity
    @goods.each do |good|
      cap -= good.amount
    end
    return cap
  end
end