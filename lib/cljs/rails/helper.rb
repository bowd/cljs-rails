require 'action_view'

module Cljs
  module Rails
    # Asset path helpers for use with webpack
    module Helper
      # Return asset paths for a particular webpack entry point.
      #
      # Response may either be full URLs (eg http://localhost/...) if the dev server
      # is in use or a host-relative URl (eg /webpack/...) if assets are precompiled.
      #
      # Will raise an error if our manifest can't be found or the entry point does
      # not exist.
      def cljs_main_path
        port = ::Rails.configuration.cljs.dev_server.port
        protocol = ::Rails.configuration.cljs.dev_server.https ? 'https' : 'http'
        main = ::Rails.configuration.cljs.main_target

        host = ::Rails.configuration.cljs.dev_server.host
        host = instance_eval(&host) if host.respond_to?(:call)

        "#{protocol}://#{host}:#{port}/#{main}.js"
      end
    end
  end
end
