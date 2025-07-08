class SessionsController < ApplicationController
  def create
    user = User.find_by(email: login_params[:email])

    if user&.authenticate(login_params[:password])
      payload = { user_id: user.id, exp: (Time.now + 24.hours).to_i }
      token = JWT.encode(payload, Rails.application.secret_key_base, 'HS256')
      render json: { token: token }
    else
      render json: { error: "Invalid Credentials" }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
