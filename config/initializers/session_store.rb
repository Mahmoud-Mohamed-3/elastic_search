Rails.application.config.session_options = {
  store: :redis_store,
  servers: [ ENV.fetch("REDIS_URL", "redis://localhost:6379/1") ],
  expire_after: 2.hours,
  key: "_elastic_search_session",
  threadsafe: false,
  secure: Rails.env.production?
}
