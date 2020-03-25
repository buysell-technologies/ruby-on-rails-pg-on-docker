class ApplicationController < ActionController::Base
    before_action :login_required

    private
    def login_required
        redirect_to login_path unless current_user
    end
end
