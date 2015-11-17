require "httparty"
require "pry"
require "eventmachine"
require "faye/websocket"

# Tell Slack to open ws
resp = Slack.new.call "rtm.start"
if resp["ok"]
  websocket_url = resp["url"]
else
  raise "Failed to connect: #{resp["error"]}"
end

# Get channel id
resp = Slack.new.call "channels.list"
chan = resp["channels"].find { |c| c["name"] == "dc_sept2015_rails" }

EM.run {
  marv = Marvin.new
  marv.each_message do |msg|
    puts msg
  end
}

# EM.run {
#   ws = Faye::WebSocket::Client.new(websocket_url, nil, ping: 25)
#
#   ws.on :open do |event|
#     puts "Ready for messages!"
#     # ws.send({
#     #   id: 1,
#     #   type: "message",
#     #   text: "Hello!",
#     #   channel: chan["id"]
#     # }.to_json)
#   end
#
#   ws.on :message do |event|
#     # p [:message, event.data]
#     content = JSON.parse event.data
#     if content["type"] == "message"
#       puts content["text"]
#     end
#   end
#
#   ws.on :close do |event|
#     p [:close, event.code, event.reason]
#     ws = nil
#   end
# }
