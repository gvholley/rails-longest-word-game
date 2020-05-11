require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
  end

  def english_word
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    word_dictionary = open(url).read
    word = JSON.parse(word_dictionary)
    word['found']
  end

  def letters_included
    params[:word].chars.each { |letter| params[:letters].include?(letter) }
  end

  def score
    @answer = params[:word]
      if !letters_included
        @result = "#{@answer} can't be made."
      elsif !english_word
        @result = "#{@answer} is not an English word."
      elsif letters_included && !english_word
        @result = "#{@answer} is not an English word."
      else letters_included && !english_word
        @result = "#{@answer} is an English word!"
      end
  end
end
