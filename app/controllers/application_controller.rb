class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  force_ssl if: :ssl_configured?
  protect_from_forgery with: :exception, unless: :devise_controller?
  before_filter :foo
  check_authorization unless: :devise_controller?

  private

  def foo
    # binding.pry
  end

  def ssl_configured?
    !Rails.env.development? && !Rails.env.test?
  end
end
