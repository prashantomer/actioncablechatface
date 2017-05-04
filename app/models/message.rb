class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  after_create_commit { MessageBroadcastJob.perform_later(self) }
  after_create :send_mail
  def send_mail
  	sender = User.find(self.user_id)
    conversation = Conversation.find(self.conversation_id)
    UserMailer.welcome_email(sender, conversation.opposed_user(sender)).deliver_now
  end
end
