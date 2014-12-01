json.array! @favorite_discussions do |favorite_discussion|
  discussion = favorite_discussion.discussion

  json.id discussion.id
  json.title discussion.title
  json.content discussion.content
  json.comments_count discussion.comments.count

  json.comments discussion.comments do |comment|
    json.id comment.id
    json.content comment.content
    json.created_at comment.created_at
    json.updated_at comment.updated_at
  end

  json.user do
    json.id discussion.user.id
    json.name discussion.user.name
    json.image do 
      json.small discussion.user.image(:small)
      json.medium discussion.user.image(:medium)
      json.big discussion.user.image(:big)
    end
  end

  json.targets discussion.targets do |target|
    json.partial! target.targetable
  end

  json.favorite true

  json.created_at discussion.created_at
  json.updated_at discussion.updated_at
end