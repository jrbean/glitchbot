class Marvin
  attr_reader :plugins

  def initialize socket = nil
    @slack_socket = socket || connect_to_slack_rtm

    @plugins = [
      Plugins::Echo.new,
      Plugins::Points.new,
      Plugins::Rules.new,
      Plugins::Pugs.new,
      Plugins::Help.new(self)
    ]
  end

  def each_message &thing_to_do
    @slack_socket.on :message do |event|
      response = handle_event JSON.parse event.data
      if response
        thing_to_do.call(response)
      end
    end
  end

  def send_message text, channel
    @slack_socket.send({
      id:      1,
      type:    "message",
      text:    text,
      channel: channel
    }.to_json)
  end

  def handle_event content
    return unless content["type"] == "message"

    @plugins.each do |p|
      begin

        if p.matches? content
          resp = p.handle content
          if resp
            send_message resp, content["channel"]
          end
        end

      rescue StandardError => e
        Rails.logger.error "#{p} failed with #{e} for #{content}"
      end
    end
  end

private

  def connect_to_slack_rtm
    return unless Rails.env.production?

    resp = Slack.new.call "rtm.start"
    if resp["ok"]
      websocket_url = resp["url"]
    else
      raise "Failed to connect: #{resp["error"]}"
    end

    Faye::WebSocket::Client.new(websocket_url, nil, ping: 25)
  end
end
