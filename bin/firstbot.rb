require "httparty"
require "pry"
require "eventmachine"
require "faye/websocket"


EM.run {
  marv = Marvin.new
  marv.each_message do |msg|
    puts msg
  end
}
