class ContactMailer < ActionMailer::Base
  default from: "bweber@spinuplabs.com"

  def webcontact(contact)
    @contact = contact
    mail(:to => 'bweber@spinuplabs.com', :subject => 'Web Contact Form')
  end
end
