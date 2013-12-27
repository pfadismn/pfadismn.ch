class UserMailer < ActionMailer::Base
  default from: "info@pfadiheime.ch"

  def contact_form_notification(user, contact_form)
    @user = user
    @contact_form = contact_form

    mail(to: @user.email, subject: 'Kontaktanfrage')
  end
end
