class Api::V1::TrainingsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_training, only: [:show, :update, :destroy]

  def index
    trainings = Training.includes(:trainer, :category)
    trainings = trainings.where(category_id: params[:category_id]) if params[:category_id].present?
    render json: trainings.as_json(include: { trainer: { only: [:id, :first_name, :last_name] } })
  end

  def show
    render json: @training.as_json(include: [:trainer, :category])
  end

  def create
    require_role!("trainer")
    training = current_user.trainer.trainings.new(training_params)
    if training.save
      render json: training, status: :created
    else
      render json: { errors: training.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    require_role!("trainer")
    return render json: { error: "Non autorise" }, status: :forbidden unless @training.trainer_id == current_user.trainer.id
    @training.update(training_params) ? (render json: @training) : (render json: { errors: @training.errors.full_messages }, status: :unprocessable_entity)
  end

  def destroy
    require_role!("trainer")
    return render json: { error: "Non autorise" }, status: :forbidden unless @training.trainer_id == current_user.trainer.id
    @training.destroy
    head :no_content
  end

  private

  def set_training
    @training = Training.find(params[:id])
  end

  def training_params
    params.permit(:title, :description, :starts_at, :ends_at, :capacity, :category_id)
  end
end
