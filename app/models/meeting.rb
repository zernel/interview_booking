class Meeting < ApplicationRecord
  belongs_to :investor
  belongs_to :user, optional: true

  enum :status, [:not_open, :open, :booked, :cancelled]

  validates :start_time, presence: true
  validates_uniqueness_of :start_time, scope: :investor_id
  validate :validate_bookings

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

  private
  def validate_bookings
    # User and the same investor can only meet once a day at most
    if booked?
      already_booked = investor.meetings.where(start_time: start_time.beginning_of_day...start_time.end_of_day).where(user: user).present?
      errors.add(:user, "can only meet once a day at most") if already_booked
    end
  end
end
