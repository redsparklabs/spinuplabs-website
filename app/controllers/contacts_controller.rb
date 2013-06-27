class ContactsController < ApplicationController
  def create
    @contact = Contact.new(params[:contact])

    if @contact.save
      flash[:notice] = "Your message has been sent.<br />Someone will be contacting your within 24-48 hours.<br /><br />If you would like immediate assistance contact us directly via phone: <strong>(866) 985-6877</strong>"
        ContactMailer.webcontact(@contact).deliver
      redirect_to pages_contact_path
    else
      flash[:error] = "Your message could not be submitted without all required fields completed."
      #redirect_to pages_contact_path
      render "pages/contact"
    end
  end

end