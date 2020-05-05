class Request < ApplicationRecord
    belongs_to :user
    belongs_to :cabinet
      
  validates :comment, length: { maximum: 255 }
  
end
