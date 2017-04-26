class RtmController < ApplicationController
  include Tubesock::Hijack

  def messages
    hijack do |socket|
      EM.run {
        g = glitch.new
        g.each_message do |msg|
          socket.send_data msg
        end
      }
    end
  end
end
