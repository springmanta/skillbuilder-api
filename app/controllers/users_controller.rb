class UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      payload = { user_id: @user.id, exp: (Time.now + 24.hours).to_i }
      token = JWT.encode(payload, Rails.application.secret_key_base, 'HS256')
      render json: { token: token }
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation)
  end
end
