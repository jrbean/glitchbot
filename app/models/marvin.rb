class Marvin
  def initialize socket = nil
    @slack_socket = socket || connect_to_slack_rtm
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
    if content["type"] == "message"
      if content["text"] =~ /marvin echo (.*)/
        send_message $1, content["channel"]
        return "Echoing '#{$1}' to '#{content['channel']}'"
      elsif content["text"] =~ /(\w+)(\+\+|--)/
        score = Score.where(name: $1).first_or_create!
        if $2 == "++"
          score.points += 1
        else
          score.points -= 1
        end
        score.save!
        send_message "#{$1} now has #{score.points} points", content["channel"]
      end
    end
  end

private

  def connect_to_slack_rtm
    # Tell Slack to open ws
    resp = Slack.new.call "rtm.start"
    if resp["ok"]
      websocket_url = resp["url"]
    else
      raise "Failed to connect: #{resp["error"]}"
    end

    # Get channel id
    resp = Slack.new.call "channels.list"
    chan = resp["channels"].find { |c| c["name"] == "_robots" }

    Faye::WebSocket::Client.new(websocket_url, nil, ping: 25)
  end
end
