json.extract! question_group, :id, :order, :name, :description, :survey_id, :created_at, :updated_at
json.url question_group_url(question_group, format: :json)
