require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Hotel
  class Application < Rails::Application
    config.load_defaults 5.2
    config.i18n.default_locale = :ja
    config.i18n.available_locales = [:en, :ja]
    config.action_view.embed_authenticity_token_in_remote_forms = true
  end
end