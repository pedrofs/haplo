json.array! @users do |user|
  json.id user.id
  json.name user.name
  json.email user.email
  json.status user.invitation_accepted? || current_user == user
  json.gravatar Digest::MD5.hexdigest(user.email)
end