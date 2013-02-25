class ContactController < ApplicationController
  layout 'spinup'

  def new
    @message = Message.new
    $seo_title = "Contact Us"
  end

  def create
    @message = Message.new(params[:message])

    if @message.valid?
      NotificationsMailer.new_message(@message).deliver
      redirect_to(root_path, :notice => "Message was successfully sent.")
    else
    	#puts "error"
      flash.now.alert = "Please fill out all fields."
      render :new
    end
  end

end
