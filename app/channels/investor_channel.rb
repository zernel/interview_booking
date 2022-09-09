class InvestorChannel < ApplicationCable::Channel
  def subscribed
    @investor = Investor.find params[:id]
    stream_from "investor-#{@investor.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
