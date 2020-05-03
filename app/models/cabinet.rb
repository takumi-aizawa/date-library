class Cabinet < ApplicationRecord
  #belongs_to :user #すべての投稿は一人のユーザに紐つく。多対１ #user idを入力しなければならない？

  validates :file_no, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :file_name, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :expired_at, presence: true, numericality: { only_integer: true } #保管期限
  validates :placed_at, presence: true, length: { maximum: 50 } #保管場所

  
end
