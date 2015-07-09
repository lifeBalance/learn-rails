class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end
  
  def create
    @contact = Contact.new(secure_params) 
    if @contact.valid?
      # The thing of writing to the spreadsheet can't be done
      # @contact.update_spreadsheet
      
      # Send email.
      UserMailer.contact_email(@contact).deliver
      
      flash[:notice] = "Message sent from #{@contact.name}." 
      redirect_to root_path
    else
      render :new
    end 
  end
  
  private
    def secure_params
      params.require(:contact).permit(:name, :email, :content)
    end
end

