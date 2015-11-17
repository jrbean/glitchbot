module Plugins
  class Points
    def matches? content
      content["text"] =~ /(\w+)(\+\+|--)/
    end

    def handle content
      content["text"] =~ /(\w+)(\+\+|--)/
      score = Score.where(name: $1).first_or_create!
      if $2 == "++"
        score.points += 1
      else
        score.points -= 1
      end
      score.save!
      "#{$1} now has #{score.points} points"
    end
  end
end
