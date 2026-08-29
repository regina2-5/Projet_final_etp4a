class Api::V1::ApplicationsController < ApplicationController
  # GET /api/v1/jobs/:job_id/applications (entreprise proprietaire de l'offre)
  def index
    job = Job.find(params[:job_id])
    require_role!("company")
    return render json: { error: "Non autorise" }, status: :forbidden unless job.company_id == current_user.company.id
    render json: job.applications.includes(:student)
  end

  # POST /api/v1/jobs/:job_id/applications (etudiant)
  def create
    require_role!("student")
    job = Job.find(params[:job_id])
    application = current_user.student.applications.new(job: job, cover_letter: params[:cover_letter])
    if application.save
      render json: application, status: :created
    else
      render json: { errors: application.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /api/v1/applications/:id
  def show
    render json: application_scope.find(params[:id])
  end

  # PATCH /api/v1/applications/:id (entreprise : accepter/rejeter)
  def update
    application = Application.find(params[:id])
    require_role!("company")
    return render json: { error: "Non autorise" }, status: :forbidden unless application.job.company_id == current_user.company.id
    if application.update(status: params[:status])
      render json: application
    else
      render json: { errors: application.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    application = current_user.student.applications.find(params[:id])
    application.destroy
    head :no_content
  end

  private

  def application_scope
    current_user.admin? ? Application.all : Application.where(student: current_user.student)
  end
end
