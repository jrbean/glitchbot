module Plugins
  class Echo
    def matches? content
      content["text"].start_with? "glitch echo"
    end

    def handle content
      content["text"] =~ /glitch echo (.*)/
      $1
    end
  end
end
