require './config/application.rb'

use Rack::ContentType

app = Blog::Application.new

app.route do
  match "/", "home#index"

  match "/:controller/:action" # /haha/hehe
end

run app
