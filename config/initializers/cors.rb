# config/initializers/cors.rb

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:3001' # Allow requests from this origin
    
    resource '*', 
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options]
  end
end
