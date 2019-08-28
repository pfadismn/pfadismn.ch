# Loads action_mailer settings from email.yml
# and turns deliveries on if configuration file is found

ActionMailer::Base.default_options = {
  from: ENV['MAIL_SENDER'],
  reply_to: ENV['MAIL_SENDER']
}
ActionMailer::Base.default_url_options = { host: ENV['APP_HOST'] }

if mailer = URI(ENV['MAILER_URL'])
  delivery_method = mailer.scheme.to_sym
  settings = { address: mailer.host, user_name: mailer.user, password: mailer.password, port: mailer.port }
  settings = settings.merge(Hash[mailer.query&.split('&')&.map { |option| option.split('=') }] || [])

  ActionMailer::Base.delivery_method = delivery_method
  ActionMailer::Base.try("#{delivery_method}_settings=", settings.symbolize_keys)
elsif Rails.env.development?
  ActionMailer::Base.delivery_method = :letter_opener
else
  ActionMailer::Base.delivery_method = :test
end
