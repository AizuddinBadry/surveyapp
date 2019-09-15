json.extract! question, :id, :question_group_id, :q_type, :code, :description, :help, :mandatory, :position, :created_at, :updated_at
json.url question_url(question, format: :json)
