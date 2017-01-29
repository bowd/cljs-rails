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
        if ::Rails.env.production?
          cljs_main_prod_path
        else
          cljs_main_dev_path
        end
      end

      def cljs_main_prod_path
        # ``app/assets/cljs-build`` has to be added to the asset paths
        main = ::Rails.configuration.cljs.main_target
        "#{main}.js"
      end

      def cljs_main_dev_path
        port = ::Rails.configuration.cljs.dev_server.port
        protocol = ::Rails.configuration.cljs.dev_server.https ? 'https' : 'http'
        main = ::Rails.configuration.cljs.main_target

        host = ::Rails.configuration.cljs.dev_server.host
        host = instance_eval(&host) if host.respond_to?(:call)

        # if ::Rails.env.developmtn

        "#{protocol}://#{host}:#{port}/#{main}.js"
      end

    end
  end
end
