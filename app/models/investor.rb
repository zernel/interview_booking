class Investor < ApplicationRecord
  has_many :meetings, dependent: :destroy

  def get_schedule_on(date)
    meetings_by_start_time = self.meetings.group_by(&:start_time)

    Meeting.generate_datetime_sequence_for(date).map do |datetime|
      if meetings_by_start_time[datetime].nil?
        Meeting.new(investor: self, start_time: datetime, status: :not_open)
      else
        meetings_by_start_time[datetime].first
      end
    end
  end
end
