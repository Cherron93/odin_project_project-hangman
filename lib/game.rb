# frozen_string_literal: true

require 'yaml'
require 'pry-byebug'

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
      answer = get_answer
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

  def get_answer
    answer = get_user_input.downcase
    save_game if answer == 'save'
    load_game if answer == 'load'
    play_game if %w[save load].include?(answer)
    answer = answer.chr if answer.length > 1
    answer
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
    filename = []
    # filename = "saved_games/#{@player_name}.yml"
    filename = "#{@player_name}.yml"
    File.open(filename, 'w') { |f| YAML.dump([] << self, f) }
    puts 'Game saved!'
  end

  def load_game
    # yaml = YAML.load_file("saved_games/#{@player_name}.yml", permitted_classes: [Hangman])
    # p yaml
    # yaml = YAML.load_file(File.read("saved_games/#{@player_name}.yml"), permitted_classes: [Hangman])
    # p yaml
    # save_file = File.read("#{@player_name}.yml")
    # save_file = File.read(File.join(File.dirname(__FILE__), "#{@player_name}.yml"))
    # yaml = YAML.load_file(save_file)
    # save_file = File.read(File.join(File.dirname(__FILE__), "#{@player_name}.yml"))
    # yaml = YAML.load_file(File.join(File.dirname(__FILE__), "#{@player_name}.yml"))
    yaml = YAML.load_file(File.read("/home/colin/odin_project/ruby/hangman/odin_project_project-hangman/#{@player_name}.yml"))
    @player_name = yaml[0].player_name
    @board_array = yaml[0].board_array
    @word = yaml[0].word
    @word_array = yaml[0].board_array
    @mistakes = yaml[0].mistakes
    @wrong_letters = yaml[0].wrongletters
    puts 'Game loaded!'
  end
end
