class UserMailer < ActionMailer::Base
  default from: "info@pfadiheime.ch"
  layout 'user_mailer'

  def contact_form(contact_form)
    attachments.inline['header.jpg'] = File.read("#{Rails.root}/app/assets/images/layouts/banner/usermailer.jpg")
    @contact_form = contact_form

    mail(to: 'andre.buerkler@u041.ch', subject: 'Kontaktanfrage pfadismn.ch')
  end

  def newsletter(receipients, news)
    attachments.inline['header.jpg'] = File.read("#{Rails.root}/app/assets/images/layouts/banner/usermailer.jpg")
    @news = news
    @receipients = receipients

    mail(bcc: @receipients, subject: @news.title)
  end

end
