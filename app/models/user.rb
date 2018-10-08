class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :validatable
  enum user_type: [:member, :admin]
  enum blocked: [:active, :blocked]
  has_many :relationships
  has_many :comments
  has_many :reviews
  has_many :replies
  has_many :likes

  validates :email, presence: true,
    length: {maximum: Settings.email_max_length},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true, allow_nil: true,
    length: {minimum: Settings.pass_min_length}

  mount_uploader :picture, PictureUploader
end
