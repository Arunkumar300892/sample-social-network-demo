class User < ApplicationRecord

  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :timeoutable, :trackable, :omniauthable,
         omniauth_providers: [:facebook, :google_oauth2]

  # mounting uploader for image
  mount_uploader :avatar, AvatarUploader
  
  # callbacks
  before_save :downcase_email

  # associations
  has_many :posts, dependent: :destroy
  has_many :comments
  has_many :likes

  # validations
  validates :email, :presence => true, uniqueness: {
    :case_sensitive => false
  }

  # scope methods
  scope :online, lambda{ where("updated_at > ?", 10.minutes.ago) }

  # public methods
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.skip_confirmation!
    end
  end

  # to get the user avatar
  def image
    if self.avatar.present?
      self.avatar.filename
    else
      "default-avatar.jpg"
    end
  end
  
  # to get full name
  def name
    [self.first_name, self.last_name].join(' ')
  end

  # to find whether a user in online
  def online?
    updated_at > 10.minutes.ago
  end

  # private methods

  private

  # changing email to lower case.
  def downcase_email
    self.email = email.downcase
  end

end
