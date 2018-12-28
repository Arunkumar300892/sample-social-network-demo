class Like < ApplicationRecord

  # associations
  belongs_to :user
  belongs_to :post
  
end
