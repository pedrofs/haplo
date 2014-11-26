json.array! @discussions do |discussion|
  json.id discussion.id
  json.content discussion.content
  json.user discussion.user, :name, :email
  json.created_at discussion.created_at
  json.updated_at discussion.updated_at
end