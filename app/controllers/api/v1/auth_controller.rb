class Api::V1::AuthController < ApplicationController
  skip_before_action :authenticate_user!, only: [:signup, :login]

  # POST /api/v1/signup
  # params: email, password, role (student|company|trainer), + champs de profil
  def signup
    role = Role.find_by(name: params[:role])
    return render json: { error: "Role invalide" }, status: :unprocessable_entity unless role

    user = User.new(email: params[:email], password: params[:password], role: role)

    ActiveRecord::Base.transaction do
      user.save!
      create_profile_for(user, role.name)
    end

    render json: { user: user_json(user), token: encode_token(user.id) }, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  # POST /api/v1/login
  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      render json: { user: user_json(user), token: encode_token(user.id) }
    else
      render json: { error: "Identifiants invalides" }, status: :unauthorized
    end
  end

  def logout
    render json: { message: "Deconnecte" }
  end

  private

  def create_profile_for(user, role_name)
    case role_name
    when "student"
      Student.create!(user: user, first_name: params[:first_name], last_name: params[:last_name])
    when "company"
      Company.create!(user: user, name: params[:company_name])
    when "trainer"
      Trainer.create!(user: user, first_name: params[:first_name], last_name: params[:last_name])
    end
  end

  def user_json(user)
    { id: user.id, email: user.email, role: user.role.name }
  end
end
