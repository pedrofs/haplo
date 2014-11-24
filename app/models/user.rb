require 'digest/md5'

Paperclip.interpolates :md5_email  do |attachment, style|
  Digest::MD5.hexdigest attachment.instance.email
end

Paperclip.interpolates :size do |attachment, style|
  case style
    when :big
      '200'
    when :medium
      '80'
    when :small
      '40'
    when :mini
      '20'
  end
end

class User < ActiveRecord::Base
  has_many :tasks, foreign_key: 'assigned_id'
  has_many :favorite_projects
  has_attached_file :image, styles: { big: "200x200>", medium: "80x80>", small: "40x40>", mini: "20x20>" }, default_url: "http://www.gravatar.com/avatar/:md5_email?s=:size"
  has_one :account, foreign_key: 'owner_id'
  belongs_to :role

  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }

  # validates :password, format: {with: /(?=.*[@#$%])/, message: "você precisa incluir um caracter especial: @#$%", multiline: true}

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

  def to_builder
    Jbuilder.new do |user|
      user.id id
      user.name name
      user.email email
      user.status invitation_accepted?
      user.image do |img|
        img.big image.url(:big)
        img.medium image.url(:medium)
        img.small image.url(:small)
        img.mini image.url(:mini)
      end
      user.role do |r|
        if role
          r.id role.id
          r.name role.name
        end
      end
      user.role_id role_id
    end
  end
end