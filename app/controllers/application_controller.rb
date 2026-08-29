class ApplicationController < ActionController::API
  before_action :authenticate_user!

  private

  # Authentification simple par token (a completer avec JWT ou Devise/JWT
  # selon vos besoins). Ici on suppose un header "Authorization: Bearer <token>".
  def authenticate_user!
    token = request.headers["Authorization"]&.split(" ")&.last
    @current_user = User.find_by(id: decode_token(token))
    render json: { error: "Non autorise" }, status: :unauthorized unless @current_user
  end

  def current_user
    @current_user
  end

  def decode_token(token)
    return nil if token.blank?
    JWT.decode(token, Rails.application.secret_key_base)[0]["user_id"]
  rescue JWT::DecodeError
    nil
  end

  def encode_token(user_id)
    JWT.encode({ user_id: user_id }, Rails.application.secret_key_base)
  end

  def require_role!(role_name)
    return if current_user.role.name == role_name || current_user.admin?
    render json: { error: "Acces refuse" }, status: :forbidden
  end
end
