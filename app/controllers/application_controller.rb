class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include MetaTagHelper

  before_action :http_auth_for_staging
  before_action :set_paper_trail_whodunnit
  before_action :set_locale

  def default_url_options
    # SUPPORT: SSL
    # { protocol: "https" }
    {}
  end


  def set_locale
    I18n.locale = extract_locale_from_accept_language_header.first.first
  end
 
  

  private

  def http_auth_for_staging
    return unless Rails.env.staging?
    authenticate_or_request_with_http_basic do |username, password|
      username == "myapp" && password == "myapp"
    end
  end

  def extract_locale_from_accept_language_header
    locale = request.env['HTTP_ACCEPT_LANGUAGE'].to_s.split(",").map { |l|
          l += ';q=1.0' unless l =~ /;q=\d+(?:\.\d+)?$/
          l.split(';q=')
        }
  end
end
