json.extract! document, :id, :name, :service_id, :stamp_required, :deafult_price, :tat, :automated, :template_url, :status_id, :description, :priorty, :user_id, :created_at, :updated_at
json.url document_url(document, format: :json)
