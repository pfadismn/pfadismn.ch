class MailerSettings
  attr_reader :settings
  delegate :[], :fetch, to: :settings

  def initialize(url)
    uri = URI(url)
    @settings = {
                  address: uri.host,
                  password: uri.password,
                  port: uri.port,
                  delivery_method: uri.scheme.to_sym
                 }
    @settings[:user_name] = URI.unescape(uri.user) if uri.user.present?
    @settings = settings.merge(extract_options(uri.query))
  end

  def to_h
    settings
  end

  private

  def extract_options(query)
    options = Hash[query&.split('&')&.map { |option| option.split('=') }] || []
    options.symbolize_keys.transform_values { |option| URI.unescape(option) }
  end
end

if ENV['MAILER_URL'].present?
  settings = MailerSettings.new(ENV['MAILER_URL'])
  ActionMailer::Base.tap do |config|
    config.default(
      from: settings.fetch(:from, 'no-reply@pfadismn.ch'),
      bcc: settings.fetch(:bcc, 'bcc@pfadismn.ch')
    )
    config.default_url_options = { host: ENV['APP_HOST'] }
    config.delivery_method = settings[:delivery_method]
    config.try("#{settings[:delivery_method]}_settings=", settings.to_h)
  end
elsif Rails.env.development?
  ActionMailer::Base.delivery_method = :letter_opener
else
  ActionMailer::Base.delivery_method = :test
end
