json.extract! column, :id, :table_id, :name, :code, :type, :created_at, :updated_at
json.url column_url(column, format: :json)
