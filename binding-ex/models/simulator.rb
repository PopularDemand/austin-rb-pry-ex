class Simulator

  def initialize(opts = {})
    @bands = opts.fetch(:bands, [Band.new])
    @players = opts.fetch(:players, [BandMember.new])
    @finished = false
  end

  def simulate
    intro
    loop do
      run_loop
      break if @finished
    end
  end

  def run_loop
    puts 'What would you like to do?'
    action = gets.chomp.downcase
    process(action)
  end

  def process(action)
    case action
      when 'new band', 'add band'
        create_band
      when 'new player', 'add player'
        create_player
      when 'transaction'
        transact
      when 'list players', 'players'
        list_players
      when 'list bands', 'bands'
        list_bands
      when 'stop', 'q', 'quit'
        finish
      else
        puts "Your options are 'new band', 'new player', " +
             "'transaction' or 'stop'."
    end
  end

  def create_band
    puts "What should the name of the band be?"
    band_name = gets.chomp
    return puts "Band name can't be blank." if band_name.empty?

    band = Band.new({
      name: band_name
    })

    @bands << band
    puts "#{band} has been created!"
    band
  end

  def create_player
    puts "What is the player's name?"
    name = gets.chomp
    return puts 'Sorry, that name has been used' unless player_unique(name)

    puts 'What does the player play?'
    instrument = gets.chomp

    band = determine_band
    player = BandMember.new({
      name: name,
      instrument: instrument
    })

    @players << player
    connect(player, band) if band

    puts "#{player} has been created!"
    player
  end

  def transact
    player = determine_player
    band = determine_band
    transaction = determine_transaction

    case transaction
    when 'join'
      connect(player, band)
    when 'leave'
      separate(player, band)
    else
      return puts "You had two options.. Now it's too late."
    end
  end

  def list_players
    puts players_string
  end

  def list_bands
    puts bands_string
  end

  def finish
    @finished = true
  end

  def connect(player, band)
    player.join_band(band) if band.add_member(player)
    puts "#{player.name} has joined #{band.name}"
  end

  def separate(player, band)
    player.leave_band if band.remove_member(player)
    puts "#{player.name} has left #{band.name}"
  end

  private
    def determine_player
      puts "Which player: #{players_string}?"
      player_name = gets.chomp
      player = @players.find { |player| player.name.downcase == player_name.downcase }
      player ? player : puts("That player doesn't exist yet! Try 'add player'")
    end

    def determine_band
      puts "Which band: #{bands_string}?"
      band_name = gets.chomp
      band = @bands.find { |band| band.name.downcase == band_name.downcase }
      band ? band : puts("That band doesn't exist yet. Try 'add band' to create it")
    end

    def determine_transaction
      puts "Join or leave?"
      gets.chomp.downcase
    end

    def intro
      puts "Welcome to the simulation.\n" +
           "These are the current bands: #{bands_string}\n" +
           "These are the unassigned players: #{free_players_string}"
    end

    def bands_string
      @bands.map(&:to_s).join(', ')
    end

    def players_string
      @players.map(&:to_s).join(', ')
    end

    def free_players_string
      @players.select { |player| player.band == nil }
              .map(&:to_s)
              .join(', ')
    end

    def player_unique(player_name)
      !@players.find { |player| player.name === player_name }
    end

end