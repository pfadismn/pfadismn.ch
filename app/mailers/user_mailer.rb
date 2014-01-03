class UserMailer < ActionMailer::Base
  default from: "info@pfadiheime.ch"
  layout :header_layout

  def contact_form(contact_form)
    @contact_form = contact_form

    mail(to: 'andre.buerkler@u041.ch', subject: 'Kontaktanfrage pfadismn.ch')
  end

  def newsletter(news)
    @news = news
    mail(bcc: @news.newsletter_receipients, subject: @news.title)
  end

  def upcoming_event(event)
    @event = event
    mail(bcc: @event.organisational_unit.members.map(&:email), subject: @event.name)
  end

  private
  def header_layout
    attachments.inline['header.jpg'] = File.read("#{Rails.root}/app/assets/images/layouts/banner/usermailer.jpg")
    'user_mailer'
  end
end
