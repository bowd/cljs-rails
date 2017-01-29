require 'action_view'

module Cljs
  module Rails
    module Helper
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

        "#{protocol}://#{host}:#{port}/#{main}.js"
      end

    end
  end
end
