require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ElasticSearch
  class Application < Rails::Application
    # Initialize configuration defaults for Rails 8.0
    config.load_defaults 8.0

    # Set Sidekiq as the Active Job queue adapter
    config.active_job.queue_adapter = :sidekiq

    # Use Redis for caching
    config.cache_store = :redis_cache_store, {
      url: ENV.fetch("REDIS_URL") { "redis://localhost:6379/1" },
      expires_in: 2.hours
    }

    # Use Redis for session storage


    # Autoload configuration
    config.autoload_lib(ignore: %w[assets tasks])

    # Add additional eager load paths if necessary
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
