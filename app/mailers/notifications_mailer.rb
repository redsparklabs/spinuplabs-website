class NotificationsMailer < ActionMailer::Base

  default :from => "bweber@spinuplabs.com"
  default :to => "bweber@spinuplabs.com"

  def new_message(message)
    @message = message
    mail(:subject => "Spinup Labs Contact Request")
  end

end
