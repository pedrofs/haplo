json.id @task.id
json.title @task.title
json.assigned @task.assigned, :name, :email
json.status @task.status
json.status_name Task::STATUSES[@task.status]
json.today today
json.progress @task.progress
json.created_at @task.created_at