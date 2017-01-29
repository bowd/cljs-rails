require 'rails'
require 'rails/railtie'
require 'cljs/rails/helper'

module Cljs
  # :nodoc:
  class Railtie < ::Rails::Railtie
    config.after_initialize do
      ActiveSupport.on_load(:action_view) do
        include Cljs::Rails::Helper
      end
    end

    config.cljs = ActiveSupport::OrderedOptions.new
    config.cljs.dev_server = ActiveSupport::OrderedOptions.new

    config.cljs.production_build_task = "prod"
    config.cljs.dev_server.port = 5555
    config.cljs.dev_server.host = 'localhost'
    config.cljs.main_target = 'main'

    rake_tasks do
      load "tasks/cljs.rake"
    end
  end
end
