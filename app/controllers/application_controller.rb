class ApplicationController < ActionController::Base
<<<<<<< HEAD
    http_basic_authenticate_with :name => ENV["BASIC_AUTH_NAME"], :password => ENV["BASIC_AUTH_PASSWORD"] if Rails.env.production?
<<<<<<< HEAD
=======


=======
   http_basic_authenticate_with :USER => ENV['BASIC_AUTH_USERNAME'], :PASS => ENV['BASIC_AUTH_PASSWORD'] if Rails.env == "production"
>>>>>>> eeee7d8278eafa040ab6921d8cba8115a83fdca4
>>>>>>> 836a343635a692edfdbec39caf699fc92d9f736e
end

