class ContactMailer < ApplicationMailer

  def contact_us(params)
    @params = params
    mail(to: 'contact@innovationfeel.com', subject: 'Received from Contact Us form')
  end
end
