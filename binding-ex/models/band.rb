class Band
  attr_accessor :name, :members

  def initialize(opts = {})
    @name = opts.fetch(:name, 'COVFEFE')
    @members = opts.fetch(:members, [])
  end

  def add_member(member)
    if @members.include?(member)
      puts "#{member.name} is already in #{@name}, silly goose!"
      return false
    end

    @members << member
  end

  def remove_member(member)
    @members.delete(member)
  end

  def to_s
    "#{@name} -- " +
    "Members: #{members_string}"
  end

  private

    def members_string
      return 'none' if @members.empty?
      @members.map(&:short_string)
      .join(", ")
    end
end