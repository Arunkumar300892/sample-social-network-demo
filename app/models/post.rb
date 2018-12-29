class Post < ApplicationRecord

  # mounting uploader for image
  mount_uploader :avatar, AvatarUploader
  
  # associations
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :likes, dependent: :destroy

  #validations
  validates :user_id, presence: :true
  validates :content, length: { maximum: 250 }

  # scope
  default_scope -> { order(created_at: :desc) }

  # to check image attached
  def avatar_attached?
    self.avatar.present?
  end

  # to return the image name
  def image
    self.avatar.filename
  end

end
