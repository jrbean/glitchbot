require "test_helper"

class DummySocket
  attr_reader :messages

  def initialize
    @messages = []
  end

  def send msg
    @messages.push JSON.parse msg
  end
end

class MarvinTest < ActiveSupport::TestCase
  test "it can echo text" do
    socket = DummySocket.new
    marvin = Marvin.new socket

    marvin.handle_event({
      "type"    => "message",
      "text"    => "marvin echo quack",
      "channel" => "3"
    })

    resp = socket.messages.last

    assert_equal "quack", resp["text"]
    assert_equal "3", resp["channel"]
  end

  test "it doesn't echo all text" do
    socket = DummySocket.new
    marvin = Marvin.new socket
    marvin.handle_event({
      "type"    => "message",
      "text"    => "general message that isn't for marvin",
      "channel" => "3"
    })

    assert_equal [], socket.messages
  end
end
