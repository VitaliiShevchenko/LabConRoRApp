class ChartChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "chart_#{params[:chart_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
