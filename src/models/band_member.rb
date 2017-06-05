class BandMember
  attr_accessor :name, :instrument, :band

  def initialize(opts = {})
    @name = opts.fetch(:name, 'NORA EFFIN JONES')
    @instrument = opts.fetch(:instrument, 'Vocals')
    @band = opts.fetch(:band, nil)
  end

  def leave_band
    @band = nil
  end

  def join_band(new_band)
    @band = new_band
  end

  def currently_in_band
    !!@band
  end

  def to_s
    str = "#{@name} on #{@instrument}"
    str += " for #{@band.name}" if @band
    str
  end

  def short_string
    "#{@name} on #{@instrument}"
  end

end