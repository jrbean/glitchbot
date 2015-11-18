module Plugins
  class Pugs
    def matches? content
      content["text"].start_with? "marvin pug"
    end

    def handle content
      if content["text"] == "marvin pug me"
        pugs 1
      else content["text"] =~ /marvin pug bomb (\d+)/
        count = $1.to_i
        if count <= 5
          pugs count
        else
          "That's too many pugs"
        end
      end
    end
  end
end
