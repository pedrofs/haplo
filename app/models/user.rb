class User < ActiveRecord::Base
  has_one :account, foreign_key: 'owner_id'
  has_many :tasks, foreign_key: 'assigned_id'

  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  before_destroy :check_ownership

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end

  def check_ownership
    !account
  end
end
