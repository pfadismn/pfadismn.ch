class UserMailer < ActionMailer::Base
  default from: "info@pfadiheime.ch"
  default content_type: 'text/html'
  layout 'user_mailer'

  def contact_form_notification(contact_form)
    @contact_form = contact_form

    mail(to: 'diego.steiner@u041.ch', subject: 'Kontaktanfrage')
  end
end
