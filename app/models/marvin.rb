class Marvin
  def initialize
    @slack_socket = connect_to_slack_rtm
  end

  def each_message &thing_to_do
    @slack_socket.on :message do |event|
      content = JSON.parse event.data
      if content["type"] == "message"
        if content["text"] =~ /marvin echo (.*)/
          @slack_socket.send({
            id:      1,
            type:    "message",
            text:    $1,
            channel: content["channel"]
          }.to_json)
        end
        thing_to_do.call(content["text"])
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
