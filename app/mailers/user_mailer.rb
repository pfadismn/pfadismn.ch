class UserMailer < ActionMailer::Base
  default from: "info@pfadiheime.ch"

  def contact_form_notification(user)
    @user = user

    mail(to: @user.email, subject: 'Kontaktanfrage')
  end
end
