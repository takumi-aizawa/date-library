class Cabinet < ApplicationRecord
  belongs_to :user #各cabinetは一人のユーザに紐つく。多対１。adminは不可 Cabinet.user（インスタンスメソッド）が使えるようになる
  has_one :request, dependent: :destroy #cabinetはrequestを持つ親。かつ１対１
  
  #ユーザの紐付け無しには cabinet を保存・編集できません。
  validates :file_no, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :file_name, presence: true, length: { maximum: 50 }, uniqueness: true
  #validates :expired_at, presence: true, numericality: { only_integer: true } #保管期限
  validates :placed_at, presence: true, length: { maximum: 50 } #保管場所
  

  #requestに登録する場合は、バリデーションが効かない
end
