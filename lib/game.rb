class Hangman
  DICTIONARY = File.read('google-10000-english-no-swears.txt').split(' ')

  def initialize(player_name)
    @player_name = player_name
    @board_array = []
    @word = generate_word
    puts @word
    @word_array = @word.split('')
    @mistakes = 0
    @wrong_letters = []
    set_up_board
    play_game
  end

  def generate_word
    word = DICTIONARY.sample
    word = DICTIONARY.sample until word.length >= 5 && word.length <= 12
    word
  end

  def play_game
    if @mistakes < 7
      puts "Wrong letters: #{@wrong_letters.join(' ')}"
      puts @board_array.join(' ')
      answer = get_user_input
      if @word_array.include?(answer)
        puts 'Correct!'
        update_board(answer)
        check_victory
        play_game
      else
        @wrong_letters.push(answer)
        @mistakes += 1
        puts "Wrong! That's #{@mistakes}/7 mistakes."
        play_game
      end
    elsif @mistakes == 7
      puts "Game over, #{player_name} - you loooose!"
    end
  end

  def update_board(answer)
    @word_array.each_with_index do |element, index|
      @board_array[index] = answer if element == answer
    end
  end

  def check_victory
    return unless @board_array == @word_array

    puts "Game over! #{player_name} is victorious!"
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
