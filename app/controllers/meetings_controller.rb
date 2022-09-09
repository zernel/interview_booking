class MeetingsController < ApplicationController
  def investor_calendar
    @investor = Investor.find(params[:investor_id])
  end

  def user_calendar
    @user = User.find(params[:user_id])
  end
end
