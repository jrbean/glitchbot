module Plugins
  class Pokedex
    def matches? content
      content["text"] =~ /(?<=\bmarvin pokedex\s)(\w+)/
    end

    def handle content
      content["text"] =~ /(?<=\bmarvin pokedex\s)(\w+)/
      "http://www.pokemon.com/us/pokedex/#{$1}"
    end
  end
end
