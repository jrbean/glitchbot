module Plugins
  class Help
    def initialize bot
      @bot = bot
    end

    def matches? content
      content["text"] == "glitch help"
    end

    def handle content
      plugs = @bot.plugins.map { |p| p.class.name }.join ", "
      "Glitch is a chatbot with the following plugins: #{plugs}"
    end
  end
end
