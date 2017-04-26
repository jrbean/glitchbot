module Plugins
  class Rules
    def matches? content
      content["text"] =~ /glitch.*the rules/
    end

    def handle _
      "A robot may not injure a human being or, through inaction, allow a human being to come to harm.\n" \
      "A robot must obey the orders given it by human beings except where such orders would conflict with the First Law.\n" \
      "A robot must protect its own existence as long as such protection does not conflict with the First or Second Laws."
    end
  end
end
