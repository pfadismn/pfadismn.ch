if Rails.env.production?
  Rails.application.config.middleware.use ExceptionNotification::Rack,
    email: {
        email_prefix: "[Exception] ",
        sender_address: %{"Pfadismn Exception Notifier" <exception_notifier@pfadismn.ch>},
        exception_recipients: %w{diego.steiner@u041.ch andre.buerkler@u041.ch}
    }
end
