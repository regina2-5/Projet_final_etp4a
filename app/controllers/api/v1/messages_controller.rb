class Api::V1::MessagesController < ApplicationController
  # GET /api/v1/messages -> conversation de l'utilisateur courant
  def index
    messages = Message.where(sender: current_user).or(Message.where(receiver: current_user))
    render json: messages.order(created_at: :asc)
  end

  def show
    render json: Message.find(params[:id])
  end

  # POST /api/v1/messages { receiver_id, content }
  def create
    message = current_user.sent_messages.new(receiver_id: params[:receiver_id], content: params[:content])
    if message.save
      Notification.create!(user_id: message.receiver_id, title: "Nouveau message",
                            content: "#{current_user.email} vous a envoye un message",
                            notifiable: message)
      render json: message, status: :created
    else
      render json: { errors: message.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
