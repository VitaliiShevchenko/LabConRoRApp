# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  include CreatorHelper
  before_action :configure_sign_in_params, only: [:create]
  before_action :verify_existence_creator, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def verify_existence_creator
    unless is_creator? sign_in_params[:email]
      flash[:notice] = "You haven't permission for authentication. Kindly contact the administrator"
      redirect_to new_user_session_path
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [ :email ])
  end
end
