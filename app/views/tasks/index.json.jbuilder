json.count @tasks.count
json.tasks @paginated_tasks do |task|
  json.id task.id
  json.title task.title
  json.description task.description
  json.assigned task.assigned.to_builder
  json.reporter task.reporter.to_builder
  json.assigned_id task.assigned_id
  json.reporter_id task.reporter_id
  json.estimated_time task.estimated_time
  json.status task.status
  json.status_name Task::STATUSES[task.status]
  json.priority_name (task.priority && Task::PRIORITIES[task.priority]) || Task::PRIORITIES[0]
  json.priority task.priority || 0
  json.today task.today || false
  json.status_name Task::STATUSES[task.status]
  json.project do
    json.id task.taskable_id
    json.name task.taskable.name
  end
  json.today task.today || false
  json.progress task.progress
  json.created_at task.created_at
end