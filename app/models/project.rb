class Project < ActiveRecord::Base
  has_many :project_phases, dependent: :destroy
  has_many :tasks, as: :taskable
  has_many :favorite_projects

  has_attached_file :image, styles: { medium: "200x200>", thumb: "80x80>" }, default_url: "/images/:style/missing.png"
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }

  validates :name, presence: true, uniqueness: true
  validates :client, presence: true

  accepts_nested_attributes_for :project_phases, allow_destroy: true

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
end
