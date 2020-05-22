class Request < ApplicationRecord
    #belongs_to :user #コンソールでRequest.user（インスタンスメソッド）が使えるようになる。Cabinet登録時にこれが悪さしてる！
    #belongs_to :cabinet #requestはひとつのcabinetにつながっている コンソールでRequest.cabinet（インスタンスメソッド）が使えるようになる。Cabinet登録時にこれが悪さしてる！
  
  validates :file_no, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :file_name, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :expired_at, presence: true, numericality: { only_integer: true } #保管期限
  validates :placed_at, presence: true, length: { maximum: 50 } #保管場所    
  validates :comment, length: { maximum: 255 }
  
end
