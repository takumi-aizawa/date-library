class Tracking < ApplicationRecord
  belongs_to :user
  belongs_to :manager
  
  validates :file_no, presence: true, length: { maximum: 255 }, uniqueness: true
  validates :file_name, presence: true, length: { maximum: 255 }, uniqueness: true
  validates :status, presence: true, numericality: { only_integer: true }
  validates :expired_at, presence: true
  validates :placed_at, presence: true, length: { maximum: 255 }
  
end
