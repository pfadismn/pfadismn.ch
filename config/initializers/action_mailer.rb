# Loads action_mailer settings from email.yml
# and turns deliveries on if configuration file is found

ActionMailer::Base.default_options = {
  from: ENV['MAIL_SENDER'],
  reply_to: ENV['MAIL_SENDER']
}
ActionMailer::Base.default_url_options = { host: ENV['APP_HOST'], port: ENV['APP_PORT'] }

if ENV['MAIL_USERNAME'].present? && ENV['MAIL_PASSWORD'].present?
  ActionMailer::Base.smtp_settings = {
    user_name: ENV['MAIL_USERNAME'],
    password: ENV['MAIL_PASSWORD'],
    address: 'smtp.sendgrid.net',
    port: 587,
    enable_starttls_auto: true,
    authentication: :plain,
    domain: ENV['APP_HOST']
  }
elsif Rails.env.development?
  ActionMailer::Base.delivery_method = :letter_opener
end
