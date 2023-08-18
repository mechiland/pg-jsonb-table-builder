json.extract! row, :id, :table_id, :values, :created_at, :updated_at
json.url row_url(row, format: :json)
