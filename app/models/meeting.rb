class Meeting < ApplicationRecord
  belongs_to :investor
  belongs_to :user
end
