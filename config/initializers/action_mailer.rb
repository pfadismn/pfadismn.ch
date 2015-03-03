# Loads action_mailer settings from email.yml
# and turns deliveries on if configuration file is found

ActionMailer::Base.default_options = {
  from: ENV['MAIL_SENDER'],
  reply_to: ENV['MAIL_SENDER'],
}
ActionMailer::Base.default_url_options = {host: ENV['APP_HOST'], port: ENV['APP_PORT']}

if Rails.env.production?
  filename = File.join(File.dirname(__FILE__), '..', 'email.yml')
  if File.file?(filename)
    mailconfig = YAML::load_file(filename)

    if mailconfig.is_a?(Hash) && mailconfig.has_key?(Rails.env)
      # Enable deliveries
      ActionMailer::Base.perform_deliveries = true

      mailconfig[Rails.env].each do |k, v|
        v.symbolize_keys! if v.respond_to?(:symbolize_keys!)
        ActionMailer::Base.send("#{k}=", v)
      end
    end
  end
elsif Rails.env.development?
  ActionMailer::Base.delivery_method = :letter_opener
end
