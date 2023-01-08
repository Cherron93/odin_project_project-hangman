class Hangman
  DICTIONARY = File.read('google-10000-english-no-swears.txt').split(' ')

  def start_game
    puts DICTIONARY.sample(2)
  end
end

read_dictionary = Hangman.new

read_dictionary.start_game
