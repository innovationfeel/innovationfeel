class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session, only: :json_request?
  before_action :set_locale

  private

  def set_locale
    I18n.locale =
      %w(en es de ru).include?(params[:locale]) ? params[:locale] : I18n.default_locale
  end

  def json_request?
    request.format.json?
  end
end
