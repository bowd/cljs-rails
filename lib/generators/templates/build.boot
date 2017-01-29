(set-env!
 :resource-paths  #{"cljs/src"}
 :dependencies '[[adzerk/boot-cljs      "1.7.228-2" :scope "test"]
                 [adzerk/boot-cljs-repl "0.3.3"      :scope "test"]
                 [adzerk/boot-reload    "0.5.0"      :scope "test"]
                 [pandeiro/boot-http    "0.7.6"      :scope "test"]
                 [crisptrutski/boot-cljs-test "0.2.2-SNAPSHOT" :scope "test"]
                 [org.clojure/clojure "1.8.0"]
                 [org.clojure/clojurescript "1.9.89"]
                 [com.cemerick/piggieback     "0.2.1"          :scope "test"]
                 [weasel                      "0.7.0"          :scope "test"]
                 [org.clojure/tools.nrepl     "0.2.12"         :scope "test"]
                 [binaryage/devtools "0.8.1"]])

(require
  '[adzerk.boot-cljs      :refer [cljs]]
  '[adzerk.boot-cljs-repl :refer [cljs-repl start-repl]]
  '[adzerk.boot-reload    :refer [reload]]
  '[crisptrutski.boot-cljs-test  :refer [exit! test-cljs]]
  '[pandeiro.boot-http    :refer [serve]])

(deftask dev []
  (comp (serve :port 5555)
        (watch)
        (speak)
        (reload :asset-host "http://localhost:5555" :on-jsload '<%= app_name %>.core/main)
        (cljs-repl)
        (cljs :source-map true :optimizations :none)))
