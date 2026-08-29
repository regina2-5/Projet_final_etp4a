class Api::V1::TrainingRegistrationsController < ApplicationController
  # GET /api/v1/trainings/:training_id/registrations (formateur)
  def index
    training = Training.find(params[:training_id])
    require_role!("trainer")
    return render json: { error: "Non autorise" }, status: :forbidden unless training.trainer_id == current_user.trainer.id
    render json: training.training_registrations.includes(:student)
  end

  # POST /api/v1/trainings/:training_id/registrations (etudiant)
  def create
    require_role!("student")
    training = Training.find(params[:training_id])
    registration = current_user.student.training_registrations.new(training: training)
    if registration.save
      render json: registration, status: :created
    else
      render json: { errors: registration.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
