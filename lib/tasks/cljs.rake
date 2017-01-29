namespace :cljs do
  desc "Compile clojurescript for production"
  task compile: :environment do
    production_build_task = Rails.configuration.cljs.production_build_task

    run_build = %{
      type boot >/dev/null 2>&1 ||
        { echo >&2 "[ERROR] Boot is not installed."; exit 1; }
      boot #{production_build_task}
    }

    sh run_build, verbose: false
  end
end
