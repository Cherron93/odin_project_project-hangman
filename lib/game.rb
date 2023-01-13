require 'yaml'

class Hangman
  DICTIONARY = File.read('google-10000-english-no-swears.txt').split(' ')

  def initialize(player_name)
    @player_name = player_name
    @board_array = []
    @word = generate_word
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
      puts "\nWrong letters: #{@wrong_letters.join(' ')}"
      puts "\n#{@board_array.join(' ')}"
      answer = get_user_input.downcase
      save_game if answer == 'save'
      load_game if answer == 'load'
      if @word_array.include?(answer)
        puts 'Correct!'
        update_board(answer)
        check_victory
        play_game
      else
        @wrong_letters.push(answer)
        @mistakes += 1
        puts "\nWrong! That's #{@mistakes}/7 mistakes."
        play_game
      end
    elsif @mistakes == 7
      puts "\nGame over, #{@player_name} - you loooose!"
    end
  end

  def update_board(answer)
    @word_array.each_with_index do |element, index|
      @board_array[index] = answer if element == answer
    end
  end

  def check_victory
    return unless @board_array == @word_array

    puts "Game over! #{@player_name} is victorious!"
  end

  def get_user_input
    puts "\nTake a guess"
    user_input = gets.chomp
  end

  def set_up_board
    @word.length.times do
      @board_array.push('_')
    end
  end

  def save_game
    filename = "saved_games/#{@player_name}.txt"
    File.open(filename, 'w') { |file| file.write(to_yaml) }
    puts 'Game saved!'
  end

  # Once you get it to load correctly, it should have a welcome back message, tell you score, letters, etc.
  def load_game
    filename = "saved_games/#{@player_name}.txt"
    game_file = File.open(filename, 'r') { |file| file.read }
    game = YAML.load(game_file)
    puts 'Game loaded'
    hangman.play_game
  end
end
