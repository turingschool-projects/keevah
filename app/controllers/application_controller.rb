class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  before_filter :reload_rails_admin, if: :rails_admin_path?

  helper_method :current_user, :current_tenant, :current_page

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, notice: 'Access Denied'
  end

  protected

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_tenant
    @current_tenant ||= Tenant.find(session[:tenant_id]) if session[:tenant_id]
  end

  def current_page
    params[:page].to_s || "1"
  end

  private

  def reload_rails_admin
    models = %W(User UserProfile)
    models.each do |m|
      RailsAdmin::Config.reset_model(m)
    end
    RailsAdmin::Config::Actions.reset

    load("#{Rails.root}/config/initializers/rails_admin.rb")
  end

  def rails_admin_path?
    controller_path =~ /rails_admin/ && Rails.env == 'development'
  end

end
