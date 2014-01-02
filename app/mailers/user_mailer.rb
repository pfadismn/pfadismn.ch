class UserMailer < ActionMailer::Base
  default from: "info@pfadiheime.ch"
  #default content_type: 'text/html'
  #layout 'user_mailer'
  layout 'user_mailer'

  def contact_form_notification(contact_form)
    attachments.inline['header.jpg'] = File.read("#{Rails.root}/app/assets/images/layouts/banner/usermailer.jpg")
    @contact_form = contact_form

    mail(to: 'andre.buerkler@u041.ch', subject: 'Kontaktanfrage pfadismn.ch')
  end

end
