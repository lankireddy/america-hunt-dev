class ContactMessagesController < ApplicationController

  # GET /contact_messages/new
  def new
    @contact_message = ContactMessage.new
  end

  # POST /contact_messages
  def create
    @contact_message = ContactMessage.new(contact_message_params)
    if @contact_message.save
      render
    else
      render :new
    end
  end

  private

    def contact_message_params
      params.require(:contact_message).permit(:email, :subject, :body)
    end
end

