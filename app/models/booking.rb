class Booking < ApplicationRecord
  belongs_to :user, :tool

  validate :start_date, presence: true
  validate :end_date, presence: true
end
