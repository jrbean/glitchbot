require "httparty"
require "pry"
require "eventmachine"
require "faye/websocket"


EM.run {
  gli = Glitch.new
  gli.each_message do |msg|
    puts msg
  end
}
