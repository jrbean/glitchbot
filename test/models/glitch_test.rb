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

class GlitchTest < ActiveSupport::TestCase
  test "it can echo text" do
    socket = DummySocket.new
    glitch = Glitch.new socket

    glitch.handle_event({
      "type"    => "message",
      "text"    => "glitch echo quack",
      "channel" => "3"
    })

    resp = socket.messages.last

    assert_equal "quack", resp["text"]
    assert_equal "3", resp["channel"]
  end

  test "it doesn't echo all text" do
    socket = DummySocket.new
    glitch = Glitch.new socket
    glitch.handle_event({
      "type"    => "message",
      "text"    => "general message that isn't for glitch",
      "channel" => "3"
    })

    assert_equal [], socket.messages
  end

  test "can give things points" do
    socket = DummySocket.new
    glitch = Glitch.new socket
    glitch.handle_event({
      "type" => "message",
      "text" => "some stuff where su++ happens"
    })

    record = Score.find_by name: "su"
    assert_equal 1, record.points

    3.times do
      glitch.handle_event({
        "type" => "message",
        "text" => "some stuff where su++ happens"
      })
    end

    record.reload
    assert_equal 4, record.points

    resp = socket.messages.last
    assert_equal "su now has 4 points", resp["text"]
  end

  test "can take points away" do
    score = Score.create! name: "asdf_zxcv", points: 5
    glitch = Glitch.new
    2.times do
      glitch.handle_event({
        "type" => "message",
        "text" => "asdf_zxcv--"
      })
    end

    score.reload
    assert_equal 3, score.points
  end

  test "it can get help" do
    socket = DummySocket.new
    glitch = Glitch.new socket
    glitch.handle_event({
      "type"    => "message",
      "text"    => "glitch help",
      "channel" => "3"
    })

    assert_includes socket.messages.last["text"], "Echo"
  end

  test "can link pokedex entries" do
    socket = DummySocket.new
    glitch = Glitch.new socket

    glitch.handle_event({
      "type"    => "message",
      "text"    => "glitch pokedex ditto",
      "channel" => "3"
    })

    resp = socket.messages.last
    assert_equal "http://www.pokemon.com/us/pokedex/ditto", resp["text"]
    assert_equal "3", resp["channel"]
  end
end
