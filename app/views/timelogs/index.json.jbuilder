json.array! @timelogs do |timelog|
    json.id timelog.id
    json.started_at timelog.started_at
    json.stopped_at timelog.stopped_at
    json.content timelog.content
    json.user timelog.user.to_builder
    json.task timelog.task.to_builder
end