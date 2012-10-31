class Daemon
  def initialize(command)
    Thread.new(command){|x|
      
    }
  end
end