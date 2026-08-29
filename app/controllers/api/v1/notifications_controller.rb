class Api::V1::NotificationsController < ApplicationController
  def index
    render json: current_user.notifications.order(created_at: :desc)
  end

  # PATCH /api/v1/notifications/:id { read: true }
  def update
    notification = current_user.notifications.find(params[:id])
    notification.update(read: params[:read])
    render json: notification
  end
end
