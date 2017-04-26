module Plugins
  class Pokedex
    def matches? content
      content["text"] =~ /(?<=\bglitch pokedex\s)(\w+)/
    end

    def handle content
      content["text"] =~ /(?<=\bglitch pokedex\s)(\w+)/
      "http://www.pokemon.com/us/pokedex/#{$1}"
    end
  end
end
