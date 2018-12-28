class Comment < ApplicationRecord

  # associations
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :comments, as: :commentable

  # validations
  validates :content, presence: :true, length: { maximum: 100 }

  # scope
  default_scope -> { order(created_at: :desc) }
  
end
