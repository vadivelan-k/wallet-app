class BasicAuthenticator
  attr_accessor :authorization

  def initialize(authorization)
    @authorization = authorization
  end

  def valid?
    Date.today.strftime('%Y-%m-%d') == @authorization
  end
end
