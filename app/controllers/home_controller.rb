class HomeController < ApplicationController

  def contact_us
    ContactMailer.contact_us(contact_us_params).deliver
  end

  private

  def contact_us_params
    params.permit(:first_name, :last_name, :email, :phone, :company, :country, :message).to_hash
  end
end
