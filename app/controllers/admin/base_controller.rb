class Admin::BaseController < ApplicationController
  default_form_builder DefaultFormBuilder
  layout "admin"
  before_action :authenticate, unless: -> { Rails.env.local? }
  before_action :set_cookie

  private 
  def authenticate
    authenticate_or_request_with_http_basic("admin") do |id, password|
      if accounts.has_key?(id.to_s)
        session[:admin_user_name] = id
        password == accounts[id.to_s]
      end
    end
  end

  def accounts
    {
      "scott"  => ENV["ADMIN_PASSWORD"],
    }
  end

  # used by audited gem (see config/initializers/audited.rb)
  def authenticated_user
    session[:admin_user_name]
  end

  def set_cookie
    session[:admin] = true
  end
end