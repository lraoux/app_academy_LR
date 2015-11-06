class ContactsController < ApplicationController
  def index
     if params.has_key?(:username)
       contacts = Contact.where(username: params[:username])
     else
       contacts = Contact.all
     end
     render json: contacts
  end

  def create
    contact = Contact.new(contact_params)
    if contact.save
      render json: contact
    else
      render(
        json: contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update!(contact_params)
      render json: @contact
    else
      render json: @contact.errors.full_messages, status: :unprocessable_entity
    end

  end

  def show
    contact = Contact.find(params[:id])
    render json: contact
  end

  def destroy
    contact = Contact.find(params[:id])
    contact.destroy
    render json: contact
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :user_id)
  end
end
