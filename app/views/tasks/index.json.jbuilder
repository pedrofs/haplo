json.count @tasks.count
json.tasks @paginated_tasks do |task|
  json.id task.id
  json.title task.title
  json.description task.description
  json.assigned task.assigned, :name, :email
  json.status task.status
  json.status_name Task::STATUSES[task.status]
  json.project do
    json.id task.taskable_id
    json.name task.taskable.name
  end
  json.today task.today || false
  json.progress task.progress
  json.created_at task.created_at
end
