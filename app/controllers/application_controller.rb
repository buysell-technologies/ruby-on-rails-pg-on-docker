class ApplicationController < ActionController::API
    include ActionController::HttpAuthentication::Token::ControllerMethods

    private
    def authenticate
        authenticate_or_request_with_http_token do |token,_options|
          @auth_user = User.find_by(token: token)
          @auth_user != nil ? true : false
        end
    end
end
