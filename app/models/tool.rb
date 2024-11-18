class Tool < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy

  validate :name, presence: true
  validate :description, presence: true
  validate :price, presence: true
end
