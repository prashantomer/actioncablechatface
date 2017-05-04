class MessagesController < ApplicationController
  def create
    @conversation = Conversation.includes(:recipient).find(params[:conversation_id])
    @message = @conversation.messages.create(message_params)

    # UserMailer.welcome_email(current_user, @conversation.opposed_user(current_user))
    # UserMailer.welcome_email(current_user, @conversation.opposed_user(current_user)).deliver_now
    # UserMailer.welcome_email(@user).deliver_later
    respond_to do |format|
      format.js
    end
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :body)
  end
end