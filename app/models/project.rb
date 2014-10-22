class Project < ActiveRecord::Base
  has_many :project_phases, dependent: :destroy
  has_many :tasks, as: :taskable

  has_attached_file :image, styles: { medium: "200x200>", thumb: "80x80>" }, default_url: "/images/:style/missing.png"
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }

  validates :name, presence: true, uniqueness: true
  validates :client, presence: true

  accepts_nested_attributes_for :project_phases, allow_destroy: true

  def to_json options = {}
    {
      id: id,
      name: name,
      client: client,
      description: description,
      image: {
        medium: image.url(:medium),
        thumb: image.url(:thumb)
      }
    }.to_json options
  end
end
