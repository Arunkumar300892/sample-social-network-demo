class Users::OmniauthController < ApplicationController

  # facebook callback
  def facebook

    if request.env["omniauth.auth"].info.email.blank?
      redirect_to "/users/auth/facebook?auth_type=rerequest&scope=email"
      return # be sure to include an return if there is code after this otherwise it will be executed
    end

    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      flash[:notice] = 'Facebook sign in successfull !'
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      flash[:error] = 'There was a problem signing you in Facebook. Please try again later!'
      redirect_to new_user_registration_url
    end
  end

  # google callback
  def google_oauth2
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      flash[:notice] = 'Facebook sign in successfull !'
    else
      session["devise.google_oauth2"] = request.env["omniauth.auth"]
      flash[:error] = 'There was a problem signing you in through Google. Please register or try signing in later.'
      redirect_to new_user_registration_url
    end 
  end

  # failure method
  def failure
    flash[:error] = 'There was a problem signing you in. Please register or try signing in later.' 
    redirect_to root_path
  end

end
