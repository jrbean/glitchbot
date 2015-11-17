class RtmController < ApplicationController
  include Tubesock::Hijack

  def messages
    hijack do |socket|
      m = Marvin.new
      m.each_message do |msg|
        socket.send_data msg
      end
    end
  end
end
