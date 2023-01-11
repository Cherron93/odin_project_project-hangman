class Hangman
  DICTIONARY = File.read('google-10000-english-no-swears.txt').split(' ')

  def initialize(player_name)
    @player_name = player_name
    @board_array = []
    @word = generate_word
    puts @word
    @word_array = @word.split('')
    @mistakes = 0
    set_up_board
    play_game
  end

  def generate_word
    word = DICTIONARY.sample
    word = DICTIONARY.sample until word.length >= 5 && word.length <= 12
    word
  end

  def play_game
    while @mistakes < 7
      answer = get_user_input
      if @word_array.include?(answer)
        puts 'Correct!'
        update_board(answer)
      else
        @mistakes += 1
        puts "Wrong! That's #{@mistakes}/7 mistakes."
      end
    end
  end

  def update_board(answer)
    position = @word_array.find_index(answer)
    @board_array[position] = answer
    puts @board_array.join(' ')
  end

  def get_user_input
    puts 'Take a guess'
    user_input = gets.chomp
  end

  # figure out a way to print a nicer lookign board!
  def set_up_board
    @word.length.times do
      @board_array.push('_')
    end
    puts @board_array.join(' ')
  end
end