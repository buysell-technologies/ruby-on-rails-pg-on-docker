class ApplicationController < ActionController::Base
<<<<<<< HEAD
    http_basic_authenticate_with :name => ENV["BASIC_AUTH_NAME"], :password => ENV["BASIC_AUTH_PASSWORD"] if Rails.env.production?


=======
   http_basic_authenticate_with :USER => ENV['BASIC_AUTH_USERNAME'], :PASS => ENV['BASIC_AUTH_PASSWORD'] if Rails.env == "production"
>>>>>>> eeee7d8278eafa040ab6921d8cba8115a83fdca4
end

