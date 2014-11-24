json.count @tasks.count
json.tasks @paginated_tasks do |task|
  json.id task.id
  json.title task.title
  json.assigned task.assigned, :name, :email
  json.progress task.progress
  json.created_at task.created_at
end
