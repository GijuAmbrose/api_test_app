# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  respond_to :json


  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate(auth_options)
    if self.resource
      sign_in(resource_name, resource)
      yield resource if block_given?
      render json: { status: { success: "Login sucessfully."} }
    else
      render json: { status: { error: ['Invalid email or password.'] }}, status: :unprocessable_entity
      return
    end
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  # private

  # def respond_with(resource, _opts = {})
  #   render json: {
  #   status: {code: 200, message: 'Logged in successfully.'},
  #   data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
  #   }
  # end
  
  # def respond_to_on_destroy
  #   head :ok
  # end
end
