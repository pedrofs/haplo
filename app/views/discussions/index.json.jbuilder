json.array! @discussions do |discussion|
  json.id discussion.id
  json.content discussion.content
  json.comments_count discussion.comments.count

  json.comments discussion.comments do |comment|
    json.id comment.id
    json.content comment.content
    json.created_at comment.created_at
    json.updated_at comment.updated_at
  end

  json.user do
    json.name discussion.user.name
    json.image discussion.user.image(:small)
  end

  json.targets discussion.targets do |target|
    json.partial! target.targetable
  end

  json.created_at discussion.created_at
  json.updated_at discussion.updated_at
end