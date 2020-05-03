class User < ApplicationRecord
  before_save { self.email.downcase! } 
  #文字をすべて小文字に変換する
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
  #空文字を許さず長さ50文字まで。重複を許さない
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    #正しいメアド形式かを判断
                    uniqueness: { case_sensitive: false }
                    #大文字小文字を区別しない
                    
                    
  has_secure_password
  #パスワードの暗号化
  #入力文字を保存させない
  #ログイン認証メソッドauthenticate？を提供
  
  has_many :cabinets #ユーザは複数のcabinet(書庫登録データ)とつながっている
  has_many :trackings #ユーザは複数のtracking(操作履歴)とつながっている
end
