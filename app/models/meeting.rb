class Meeting < ApplicationRecord
  belongs_to :investor
  belongs_to :user, optional: true

  enum :status, [:not_open, :open, :booked, :cancelled]

  validates :start_time, presence: true
  validates_uniqueness_of :start_time, scope: :investor_id

  # 9am-5pm, every 15 mins
  DURATION = 15.minutes
  def self.generate_datetime_sequence_for(date)
    start_at = date.change({ hour: 9, min: 0, sec: 0 })
    end_at = date.change({ hour: 17, min: 0, sec: 0 })
    datetimes = [start_at]
    while datetimes.last < (end_at - DURATION)
      datetimes << (datetimes.last + DURATION)
    end

    datetimes
  end
end
