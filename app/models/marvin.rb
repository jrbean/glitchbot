class Marvin
  def each_message &thing_to_do
    20.times do
      thing_to_do.call("hello")
      sleep 1
    end
  end
end
