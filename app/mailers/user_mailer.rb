class UserMailer < ApplicationMailer
	default from: 'prashantyuvasoft165@gmail.com'
 
  def welcome_email(sender, receiver)
    @sender = sender
    @receiver = receiver
    mail(to: @receiver.email, subject: "New Message from #{@sender.email.split('@').first}")
  end
end
