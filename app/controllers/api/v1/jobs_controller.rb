class Api::V1::JobsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_job, only: [:show, :update, :destroy]

  # GET /api/v1/jobs?category_id=&contract_type=&location=
  def index
    jobs = Job.active.includes(:company, :category)
    jobs = jobs.where(category_id: params[:category_id]) if params[:category_id].present?
    jobs = jobs.where(contract_type: params[:contract_type]) if params[:contract_type].present?
    jobs = jobs.where("location ILIKE ?", "%#{params[:location]}%") if params[:location].present?
    render json: jobs.as_json(include: { company: { only: [:id, :name] } })
  end

  def show
    render json: @job.as_json(include: { company: {}, category: {} })
  end

  # POST /api/v1/jobs (entreprise uniquement)
  def create
    require_role!("company")
    job = current_user.company.jobs.new(job_params)
    if job.save
      render json: job, status: :created
    else
      render json: { errors: job.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    require_role!("company")
    return render json: { error: "Non autorise" }, status: :forbidden unless @job.company_id == current_user.company.id
    if @job.update(job_params)
      render json: @job
    else
      render json: { errors: @job.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    require_role!("company")
    return render json: { error: "Non autorise" }, status: :forbidden unless @job.company_id == current_user.company.id
    @job.destroy
    head :no_content
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.permit(:title, :description, :contract_type, :location, :category_id, :active)
  end
end
