# frozen_string_literal: true

Sidekiq.configure_server do |config|
  config.redis = {
    url: ENV.fetch('SIDEKIQ_REDIS_URL', 'redis://localhost:6379')
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: ENV.fetch('SIDEKIQ_REDIS_URL', 'redis://localhost:6379')
  }
end