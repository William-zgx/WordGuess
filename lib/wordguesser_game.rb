class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
    @word_with_guesses = "-"*word.length
    return self
  end
  
  def guess(letter)
    def is_letter?(lookAhead)
      # Helper function to check if the input is a letter
      return lookAhead.match?(/[[:lower:]]/)
    end
    
    if letter == nil
      raise ArgumentError.new("Guess cannot be nil") 
    elsif letter == ""
        raise ArgumentError.new("Guess must be nonempty")
    elsif !letter.match?(/[[:alpha:]]/)
      raise ArgumentError.new("Guess must be letter")
    end
    
    if !is_letter?(letter) or @guesses.include?(letter)\
      or @wrong_guesses.include?(letter)
      return FALSE
    end
    
    if @word.include?(letter)
      @guesses += letter
      
      for i in 0...@word.length
        if @word[i] == letter
          @word_with_guesses[i] = letter
        end
      end
    else
      @wrong_guesses += letter
    end
    return TRUE
  end
  
  def check_win_or_lose()
    if @wrong_guesses.length >= 7
      return :lose
#     elsif @guesses.length == @word.length
    elsif !@word_with_guesses.include?("-")
      return :win
    else
      return :play
    end
  end
  
  def word()
    return @word
  end
  
  def guesses()
    return @guesses
  end
  
  def wrong_guesses()
    return @wrong_guesses
  end
  
  def word_with_guesses()
    return @word_with_guesses
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesser.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
