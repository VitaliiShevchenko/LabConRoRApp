# config/initializers/sidekiq.rb
Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/0' }

  # Load Sidekiq Scheduler
  schedule_file = "config/sidekiq.yml"
  if File.exist?(schedule_file)
    Sidekiq::Scheduler.load_schedule!
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/0' }
end
