require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array.new(9) { ('A'..'Z').to_a.sample }
  end

  def score
    @letters = params[:letters].downcase.split(' ')
    @answer = params[:answer].downcase

    if check_letters?(@answer, @letters) && english_word?(@answer)
      @response = "#{@answer} is a valid word!"
    else
      @response = "Sorry, #{@answer} is not a valid word."
    end
  end

  def home
  end

  private

  # def compute_score(attempt, time_taken)
  #   time_taken > 60.0 ? 0 : attempt.size * (1 - time_taken / 60.0)
  # end


  # rubocop no like uri.open

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    result = JSON.parse(URI.parse(url).open.read)
    result['found']
  end

  def check_letters?(attempt, grid)
    attempt.chars.all? { |letters| attempt.count(letters) <= grid.count(letters) }
  end

  # def score_and_message(attempt, grid, time)
  #   if check_letters?(attempt.upcase, grid)
  #     if english_word?(attempt)
  #       score = compute_score(attempt, time)
  #       [score, 'Well done']
  #     else
  #       [0, 'Not an english word']
  #     end
  #   else
  #     [0, 'Not in the grid']
  #   end
  # end

  # def run_game(attempt, grid, start_time, end_time)
  #   result = { time: end_time - start_time }
  #   score_and_message = score_and_message(attempt, grid, result[:time])
  #   result[:score] = score_and_message.first
  #   result[:message] = score_and_message.last
  #   result
  # end
end
