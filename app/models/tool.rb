class Tool < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many_attached :photo

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
end
