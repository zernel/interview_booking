class MeetingsController < ApplicationController
  def investor_calendar
    @investor = Investor.find(params[:investor_id])
    @date = params[:date] ? Time.zone.parse(params[:date]) : Time.zone.now.beginning_of_day
  end

  def user_calendar
    @user = User.find(params[:user_id])
    @investor = params[:investor_id] ? Investor.find(params[:investor_id]) : Investor.first
    @meetings = @investor.meetings.order(start_time: :asc)
  end

  # This action is used for investor
  # Investor set a time available for meeting will be triggered
  def create
    @investor = Investor.find(params[:investor_id]) if params[:investor_id]
    @meeting = Meeting.create!(investor: @investor, start_time: Time.zone.at(params[:start_time].to_i), status: :open)
    @date = @meeting.start_time.beginning_of_day

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("calendar_card-#{@meeting.start_time.to_i}",
                               partial: "meetings/investor_calendar_card",
                               locals: {meeting: @meeting, investor: @investor})
        ]
      end
      format.html { redirect_to investor_calendar_url(@investor) }
    end
  rescue Exception => e
    # TODO
    require 'pry'; binding.pry
  end

  # This action is used for investor
  # Investor may close the meeting which is not booked
  def destroy
    @meeting = Meeting.find(params[:id])
    raise "You can only disable a meeting which is opening for booking. (meeting##{@meeting.id})" unless @meeting.open?

    start_time = @meeting.start_time
    @investor = @meeting.investor

    # used for generate the new calendar card element
    new_attrs = @meeting.attributes.slice("start_time", "investor_id").merge(status: :not_open)

    @meeting.destroy!

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("calendar_card-#{start_time.to_i}", partial: "meetings/investor_calendar_card", locals: {meeting: Meeting.new(new_attrs), investor: @investor})
        ]
      end
      format.html { redirect_to investor_calendar_url(@investor) }
    end
  rescue Exception => e
    # TODO
    require 'pry'; binding.pry
  end

  # This action is used for user
  # User will book the open meeting
  def book
    @user = User.find(params[:user_id]) if params[:user_id]
    @meeting = Meeting.find(params[:id])
    @investor = @meeting.investor

    raise "You can only book a open meeting (meeting##{@meeting.id})" unless @meeting.open?
    @meeting.update!(user: @user, status: :booked)

    # Brodcase the updated calendar card for inventor
    ActionCable.server.broadcast(
      "booking-#{@meeting.investor.id}",
      {
        located_id: "calendar_card-#{@meeting.start_time.to_i}",
        content: render_to_string(partial: 'meetings/investor_calendar_card', locals: { meeting: @meeting, investor: @investor })
      }
    )

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("calendar_card-#{@meeting.start_time.to_i}", partial: "meetings/user_calendar_card", locals: {meeting: @meeting, user: @user})
        ]
      end
      format.html { redirect_to user_calendar_path(@user) }
    end
  end
end
