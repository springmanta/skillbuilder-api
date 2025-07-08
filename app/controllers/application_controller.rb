class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { error: e.message }, status: :not_found
  end

  rescue_from JWT::DecodeError do |_e|
    render json: { error: "Unauthorized" }, status: :unauthorized
  end

  def authorize_request
    token = request.headers["Authorization"]&.split(' ').last
    decoded = JsonWebToken.decode(token)
    @current_user = User.find(decoded["user_id"])
  end
end
