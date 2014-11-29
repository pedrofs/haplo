class Project < ActiveRecord::Base
  include Targetable

  has_many :tasks, as: :taskable
  has_many :favorite_projects

  has_attached_file :image, styles: { medium: "200x200>", thumb: "80x80>" }, default_url: "/images/:style/missing.png"
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }

  validates :name, presence: true, uniqueness: true
  validates :client, presence: true

  def to_builder
    Jbuilder.new do |project|
      project.id id
      project.name name
      project.client client
      project.description description
      project.image do |img|
        img.medium image.url :medium
        img.thumb image.url :thumb
      end
    end
  end

  def label
    name
  end
end
