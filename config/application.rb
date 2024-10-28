require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Vincent
  class Application < Rails::Application
    config.load_defaults 8.0
    config.autoload_lib(ignore: %w[assets tasks])
    config.cache_store = :solid_cache_store
    config.active_job.queue_adapter = :solid_queue
    config.solid_queue.connects_to = { database: { reading: :queue, writing: :queue } }
  end
end
