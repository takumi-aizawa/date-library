class Request < ApplicationRecord
    blongs_to :user
    blongs_to :cabinet
      
  validates :comment, length: { maximum: 255 }
  
end
