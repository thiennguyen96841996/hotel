class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :validatable
  enum user_type: [:member, :admin, :mod]
  enum blocked: [:active, :blocked]
  has_many :relationships
  has_many :comments
  has_many :reviews
  has_many :replies
  has_many :likes
  PASSWORD_VALIDATOR = /(      # Start of group
        (?:                        # Start of nonmatching group, 4 possible solutions
          (?=.*[a-z])              # Must contain one lowercase character
          (?=.*[A-Z])              # Must contain one uppercase character
          (?=.*\W)                 # Must contain one non-word character or symbol
        |                          # or...
          (?=.*\d)                 # Must contain one digit from 0-9
          (?=.*[A-Z])              # Must contain one uppercase character
          (?=.*\W)                 # Must contain one non-word character or symbol
        |                          # or...
          (?=.*\d)                 # Must contain one digit from 0-9
          (?=.*[a-z])              # Must contain one lowercase character
          (?=.*\W)                 # Must contain one non-word character or symbol
        |                          # or...
          (?=.*\d)                 # Must contain one digit from 0-9
          (?=.*[a-z])              # Must contain one lowercase character
          (?=.*[A-Z])              # Must contain one uppercase character
        )                          # End of nonmatching group with possible solutions
        .*                         # Match anything with previous condition checking
      )/x                          # End of group

  validates :email, presence: true,
    length: {maximum: Settings.email_max_length},
    uniqueness: {case_sensitive: false}
  validate :password_complexity
  scope :order_user, ->{order created_at: :desc}

  def active_for_authentication?
    super && !blocked?
  end

  def inactive_message
    blocked? ? I18n.t("flash.blocked") : super
  end

  def block_check string1, string2
    if blocked?
      string1
    else
      string2
    end
  end

  def mod_check string1, string2
    if mod?
      string1
    else
      string2
    end
  end

  def handle type
    if type == 1
      block_check Settings.unblock, Settings.block
    elsif type == 2
      block_check "users.unblock", "users.block"
    elsif type == 3
      block_check "btn btn-success", "btn btn-danger"
    elsif type == 4
      mod_check Settings.member, Settings.mod
    elsif type == 5
      mod_check "users.member", "users.mod"
    else
      mod_check "btn btn-danger", "btn btn-success"
    end
  end

  private

  def password_complexity
    return if password.blank? || password =~ PASSWORD_VALIDATOR

    errors.add :password, I18n.t("activerecord.errors.models.user.attributes.password.invalid")
  end

  mount_uploader :picture, PictureUploader
end
