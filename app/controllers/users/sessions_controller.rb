# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
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

  # If you have extra params to permit, append them to the sanitizer.
  def verify_existence_creator
    creator = Creator.find_by(user_id: User.where(email: sign_in_params[:email]).first&.id)
    flash[:notice] = "You haven't permission for authentication. Kindly contact the administrator" if creator.nil?
    redirect_to new_user_session_path    if creator.nil?
  end

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [ :email ])
  end
end
