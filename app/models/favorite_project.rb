class FavoriteProject < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates_presence_of :user_id, :project_id

  def self.toggle_project_for_user project, user
    favorite_project = current_favorite_project_for_user(project, user)

    return favorite_project.destroy if favorite_project

    create user_id: user.id, project_id: project.id
  end

  private

  def self.current_favorite_project_for_user project, user
    find_by project_id: project.id, user_id: user.id
  end
end
