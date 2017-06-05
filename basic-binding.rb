class Cat

  def initialize(opt = {})
    @name = opts.fetch(:name, 'Sgt. Meowzers')
  end

  def broken_meow
    binding.pry
    puts meow # Why wont this work??
  end

end