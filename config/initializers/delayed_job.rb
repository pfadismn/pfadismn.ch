Delayed::Worker.sleep_delay = ENV['DELAYED_WORKER_SLEEP_DELAY'].try(:to_i) || 5
