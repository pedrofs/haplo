json.id @user.id
json.name @user.name
json.email @user.email
json.status @user.invitation_accepted? || current_user == @user
json.image do |img|
  img.big @user.image.url(:big)
  img.medium @user.image.url(:medium)
  img.small @user.image.url(:small)
  img.mini @user.image.url(:mini)
end
json.role do |r|
  if @user.role
    r.id @user.role.id
    r.name @user.role.name
  end
end
json.role_id @user.role_id