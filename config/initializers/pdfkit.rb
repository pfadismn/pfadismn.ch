PDFKit.configure do |config|
  config.wkhtmltopdf = '/usr/local/bin/wkhtmltopdf' if Rails.env.production?
  config.default_options = {
      encoding: 'UTF-8',
  }
end