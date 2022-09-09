class Meeting < ApplicationRecord
  belongs_to :investor
  belongs_to :user, optional: true

  enum :status, [:not_open, :open, :booked, :cancelled]

  # 9am-5pm, every 15 mins
  def self.generate_datetime_sequence_for(date)
    start_at = date.change({ hour: 9, min: 0, sec: 0 })
    end_at = date.change({ hour: 17, min: 0, sec: 0 })
    period = 15.minutes
    datetimes = [start_at]
    while datetimes.last < (end_at - period)
      datetimes << (datetimes.last + period)
    end

    datetimes
  end
end
