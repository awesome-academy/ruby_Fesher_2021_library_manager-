class ApplicationController < ActionController::Base
  include SessionsHelper
  include Pagy::Backend
  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: User::PROPERTIES
    devise_parameter_sanitizer.permit :account_update, keys: User::PROPERTIES
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def load_books
    @q = Book.ransack(params[:query])
  end
end
