json.id @task.id
json.title @task.title
json.assigned @task.assigned, :name, :email
json.status @task.task_status, :name
json.progress @task.progress
json.created_at @task.created_at