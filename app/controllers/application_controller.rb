class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  force_ssl if: :ssl_configured?
  # protect_from_forgery with: :exception, unless: :devise_controller?
  check_authorization unless: :devise_controller?

  private

  # CanCan
  # ======================================================
  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    respond_to do |format|
      if current_user
        error_json = { errors: { message: 'You are not authorized to perform this action', status: 403 } }
        format.html do
          flash[:alert] = exception.message
          redirect_to root_path, status: 403
        end
        format.json { render json: error_json, status: 403 }
        format.js { render json: error_json, status: 403 }
      else
        error_json = { errors: { message: 'You are not authorized to perform this action', status: 401 } }
        format.html do
          flash[:alert] = exception.message
          redirect_to root_path, status: 401
        end
        format.json { render json: error_json, status: 403 }
        format.js { render json: error_json, status: 403 }
      end
    end
  end

  def ssl_configured?
    !Rails.env.development? && !Rails.env.test?
  end
end
