module Plugins
  class Echo
    def matches? content
      content["text"].start_with? "marvin echo"
    end

    def handle content
      content["text"] =~ /marvin echo (.*)/
      $1
    end
  end
end
