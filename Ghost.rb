class Player
  attr_reader :name, :strikes
  def initialize(name)
    @name = name
    @strikes = 0
  end

  def guess
    puts "Enter a letter"
    return gets.chomp
  end

  def alert_invalid_guess
  end

  def strike
    @strikes += 1
  end
end

class Game
  attr_reader :p1,:p2,:cur_player,:fragment,:dict
  def initialize(playerone,playertwo,dict)
    @p1 = Player.new(playerone)
    @p2 = Player.new(playertwo)
    @cur_player = p1
    @fragment = ""
    @dict = dict
  end

  def word_check?
    dict.include?(fragment)
  end

  def take_turn
    play = cur_player.guess
    fragment << play if valid_play?(play)
    if word_check?
      cur_player.strike
      @fragment = ""
    end
    # if cur_player == p1
    #   cur_player = p2
    # else
    #   cur_player = p1
    # end
    @cur_player, @p2 = p2, cur_player
  end



  def valid_play?(play)
    dict.each do |word|
      return true if word.include?(fragment + play)
    end
    false
  end

  def game_over?
    cur_player.strikes == 5
  end

  def play
    while !game_over?
      take_turn
      display
    end
    return "#{cur_player.name} lost!"
  end

  def display
    puts "Fragment is #{fragment}, #{cur_player.name}'s turn."
  end

end

dict = File.readlines('dictionary.txt')
dict.map!{|word| word.gsub("\n","")}
game = Game.new("john","bob",dict)
puts game.play
