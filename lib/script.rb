class Hangman
  DICTIONARY = File.read('google-10000-english-no-swears.txt').split(' ')

  def initialize(player_name)
    @player_name = player_name
    @word = generate_word
    set_up_board
  end

  def generate_word
    @word = DICTIONARY.sample
    if @word.length < 5
      @word = DICTIONARY.sample
    elsif @word.length > 12
      @word = DICTIONARY.sample
    end
    @word
  end

  # figure out a way to print a nicer lookign board!
  def set_up_board
    board_array = []
    @word.length.times do
      board_array.push('_')
    end
    board = board_array.to_s
    puts board
  end
end

game_one = Hangman.new('Thomas')

game_one.generate_word
