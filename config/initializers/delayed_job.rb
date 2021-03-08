Delayed::Worker.sleep_delay = ENV['DELAYED_WORKER_SLEEP_DELAY'].try(:to_i) || 900
Delayed::Worker.destroy_failed_jobs = true
Delayed::Worker.max_attempts = 4
