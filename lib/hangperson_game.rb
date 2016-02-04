class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
    @count = 0
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess(letter) 
    #make sure it is a letter and that it has not already been guessed
    if letter.nil?
	raise ArgumentError
    end
    if letter.empty? 
	raise ArgumentError
    end
    if not letter =~ /[a-zA-Z]$/
	raise ArgumentError
    end
    letter = letter.downcase
    if @guesses.include? letter or @wrong_guesses.include? letter
	return false
    end 
    #update instance variables: wrong_guesses and guesses
    if @word.include? letter
	@guesses += letter
    else
	@wrong_guesses += letter
    end
    @count += 1
  end 

  def check_win_or_lose
    if word_with_guesses ==  @word
	:win
    elsif @count >= 7
	:lose
    else
	:play
    end 
  end

  def word_with_guesses
    so_far  = ""
    @word.split(//).each do |letter| 
	if @guesses.include? letter
	  so_far += letter
        else
     	  so_far += '-'
        end
    end
    return so_far
  end 


end
