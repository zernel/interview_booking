class MeetingsController < ApplicationController
  def investor_calendar
    @investor = Investor.find(params[:investor_id])
    @date = params[:date] ? Time.zone.parse(params[:date]) : Time.zone.now.beginning_of_day
  end

  def user_calendar
    @user = User.find(params[:user_id])
  end
end
