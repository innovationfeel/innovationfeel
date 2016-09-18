class HomeController < ApplicationController

  def contact_us
    ContactMailer.contact_us(contact_us_params).deliver
    render json: { message: t('messages.has_been_sent') }
  rescue
    render json: { message: t('messages.something_went_wrong') }, status: 500
  end

  private

  def contact_us_params
    params.require(:client).permit(:first_name, :last_name, :email, :phone, :company, :country, :message)
  end
end
