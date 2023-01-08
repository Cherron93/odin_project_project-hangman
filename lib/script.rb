class Hangman
  DICTIONARY = File.read('google-10000-english-no-swears.txt').split(' ')

  def generate_word
    word = DICTIONARY.sample
    if word.length < 5
      word = DICTIONARY.sample
    elsif word.length > 12
      word = DICTIONARY.sample
    end
    puts word
  end
end

game_one = Hangman.new

game_one.generate_word
