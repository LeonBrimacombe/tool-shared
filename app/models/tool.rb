class Tool < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  belongs_to :user
  has_many :bookings, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true

  CATEGORIES = [
    'Batteries',
    'Chargers and Power Supplies',
    'Power Tools',
    'Outdoor Power Equipment',
    'Sewage and Drain Cleaning',
    'Lighting',
    'Instruments',
    'Storage',
    'Personal Protective Equipment',
    'Heated Work Wear and Clothing',
    'Hand Tools'
  ]
end
