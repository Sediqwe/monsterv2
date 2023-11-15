json.extract! todo, :id, :name, :desc, :user_id, :prio, :kesz, :created_at, :updated_at
json.url todo_url(todo, format: :json)
