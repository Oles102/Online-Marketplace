json.extract! product, :id,:user_id,:name,:price, :description, :category_id, :created_at, :updated_at
json.url product_url(product, format: :json)
