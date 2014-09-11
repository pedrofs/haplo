class Project < ActiveRecord::Base
  belongs_to :client

  validates :name, presence: true, uniqueness: true
  validates :client, presence: true
end
