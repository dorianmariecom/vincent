require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Vincent
  class Application < Rails::Application
    config.load_defaults 8.0
    config.autoload_lib(ignore: %w[assets tasks])
    config.cache_store = :solid_cache_store
    config.active_job.queue_adapter = :solid_queue
    config.solid_queue.connects_to = { database: { reading: :queue, writing: :queue } }
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = Rails.application.credentials.smtp
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true
  end
end
