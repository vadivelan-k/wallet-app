class ApplicationController < ActionController::API
  before_action :verify_request

  private
  def verify_request
    authenticator = BasicAuthenticator.new(request.headers["HTTP_AUTHORIZATION"])

    if !authenticator.valid?
      head :forbidden
    end
  end
end
