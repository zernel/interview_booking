class MeetingsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "meetings"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
