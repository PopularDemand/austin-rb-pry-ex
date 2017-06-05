class Calculator
  attr_accessor :in_memory

  def initialize(opts = {})
    @in_memory = opts.fetch(:in_memory, 0)
  end

  def add(num)
    @in_memory += num
  end

  def subtract(num)
    @in_memory -= num
  end

  def multiply(num)
    @in_memory *= num
  end

  def divide(num)
    @in_memory /= num
  end

  def clear
    @in_memory = 0
  end
end