module CljsRails
  # :nodoc:
  class InstallGenerator < ::Rails::Generators::Base
    source_root File.expand_path("../../templates", __FILE__)

    desc "Install everything you need for a basic cljs-rails integration"

    argument :app_name,
             type: :string,
             default: ::Rails.application.class.parent_name.downcase,
             banner: "app_name"


    def add_foreman_to_gemfile
      gem 'foreman'
    end

    def copy_procfile
      copy_file "Procfile", "Procfile"
    end

    def copy_build_boot
      template("build.boot", "build.boot")
    end

    def copy_boot_properties
      copy_file "boot.properties", "boot.properties"
    end

    def create_core_cljs
      empty_directory "cljs/src/#{app_name}"
      template("core.cljs", "cljs/src/#{app_name}/core.cljs")
    end

    def create_main_edn
      template("main.cljs.edn", "cljs/src/main.cljs.edn")
    end

    def add_to_gitignore
      append_to_file ".gitignore" do
        <<-EOF.strip_heredoc
        # Added by cljs-rails
        /app/assets/cljs-build
        .nrepl-port
        EOF
      end
    end

    def whats_next
      puts <<-EOF.strip_heredoc

        We've set up the basics of clojurescript-rails for you, but you'll still
        need to:

          1. Add the 'main' entry point into your layout, and
          2. Run 'foreman start' to run the boot build and rails server

        See the README.md for this gem at
        https://github.com/bogdan-dumitru/cljs-rails/blob/master/README.md
        for more info.

        Have a functional day!
      EOF
    end
  end
end
