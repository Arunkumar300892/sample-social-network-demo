class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # callbacks
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :user_activity

  # protected methods
  protected

  def after_sign_in_path_for(resource)
    posts_path || root_path
  end

  def configure_permitted_parameters
    added_attr = [
      :first_name, :last_name, :email, :password
    ]
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(
        added_attr,
        :password
      )
    end

    devise_parameter_sanitizer.permit(:sign_in) do |u|
      u.permit(:email, :password, :remember_me)
    end
    
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(
        added_attr,
        :current_password,
        :avatar
      )
    end
  end

  # private methods
  private

  def user_activity
    current_user.try :touch
  end

end
