json.id @user.id
json.name @user.name
json.email @user.email
json.role do |r|
  if @user.role
    r.id = @user.role.id
    r.name = @user.role.name
  end
end