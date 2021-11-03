class RoomChannel < ApplicationCable::Channel


  def subscribed
    stream_from "room"
  end

  def receive(data)
    ActionCable.server.broadcast("room", data)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
