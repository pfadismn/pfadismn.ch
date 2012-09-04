if Rails.env.production?
  Rails.application.config.middleware.use ExceptionNotifier,
    :email_prefix => "Exception Notification Pfadismn ",
    :sender_address => %{"Pfadismn Exception Notifier" <exception_notifier@pfadismn.ch>},
    :exception_recipients => %w{diego.steiner@u041.ch andre.buerkler@u041.ch}
end
