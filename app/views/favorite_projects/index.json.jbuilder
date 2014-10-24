json.array! @favorite_projects do |favorite_project|
  project = favorite_project.project

  json.id project.id
  json.name project.name
  json.client project.client
  json.description project.description
  json.created_at project.created_at
  json.updated_at project.updated_at
  json.image do |img|
    img.medium project.image.url(:medium)
    img.thumb project.image.url(:thumb)
  end
end