module Plugins
  class Pugs
    def matches? content
      content["text"].start_with? "glitch pug"
    end

    def handle content
      if content["text"] == "glitch pug me"
        pugs 1
      else content["text"] =~ /glitch pug bomb (\d+)/
        pugs $1.to_i
      end
    end

    private

    def pugs count
      if count == 1
        response = HTTParty.get "http://pugme.herokuapp.com/random"
        response["pug"]
      elsif count <= 5
        count.times.map do
          response = HTTParty.get "http://pugme.herokuapp.com/random"
          response["pug"]
        end
      else
        "too many pugs, dude"
      end
    end
  end
end
