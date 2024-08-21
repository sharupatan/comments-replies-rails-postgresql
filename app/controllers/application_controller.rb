class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token, if: :request_from_api?

    def request_from_api?
        request.path.starts_with?("/api/")
    end
end
