require 'rest-client'
require 'json'
#This was a coding challenge where I had to guess the correct number by sending a guess through a POST request to an api.

class VandricoChallenge

def initialize
  @num = 1
  @guess = {'guess' => @num}
end

def set_guess(num)
  @guess = {'guess' => num }
end

def make_guess
  request = RestClient.post "http://52.8.142.239:8080/guess", guess.to_json, :content_type => :json, :accept => :json
  parse_request(request)
end

def parse_request(request)
   parse_response = JSON.parse(request)
   @response = parse_response.values[0]
end

def set_bounds
  @iMin = @num
  until @response == "too high"
    @num*= 10
    set_guess(@num)
    make_guess
  end
  @iMax = @num
end

def answer_logic
  @iMid = ((@iMax-@iMin)/2) + @iMin
  @num = @iMid
  set_guess(@num)
  make_guess
  if @response == "too high"
    @iMax = @num
    answer_logic
  elsif @response == "too low"
    @iMin = @num
    answer_logic
  end
  return @iMid
end

def get_answer
  set_bounds
  answer_logic
end

end
