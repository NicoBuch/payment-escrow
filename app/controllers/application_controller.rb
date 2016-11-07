class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def index
    @transactions = Transaction.joins(:address)
                               .where('payer_id = :id OR receiver_id = :id', current_user.id)
  end

  protected

  def render_errors(message, path)
    notice[:error] = message
    redirect_to path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:public_key])
  end
end
