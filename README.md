[![Build Status](https://travis-ci.org/bogdan-dumitru/cljs-rails.svg?branch=master)](https://travis-ci.org/bogdan-dumitru/cljs-rails) [![Gem Version](https://badge.fury.io/rb/cljs-rails.svg)](http://badge.fury.io/rb/cljs-rails)

# cljs-rails

**Join the functional bandwagon now in just a few easy steps!**

If you're reading this you're either:

- (a) sitting in lawnchair relaxed because you've [found happiness](https://www.youtube.com/watch?v=A0VaIKK2ijM)
- (b) on your way to becoming fundamentally a better person

**cljs-rails** wants to help you integrate clojurescript into an existing Rails application without too much hassle. It depends [boot](https://github.com/boot-clj/boot) on boot for building your assets and provide a minimal template to get up and running fast with that functional goodness. 

## Boot vs Leiningen

> Potential for flamewar, check.

I'm new to the clojurescript universe and after playing around a bit with the tools I found boot to provide a smoother startup experience, especially for people who are just getting started with the ecosystem. Granted the design choice diverges a bit from the *data all the way down* that we hold dear, their [arguments](https://news.ycombinator.com/item?id=8553189) seem to hold water.

## Installation

First install boot. See the [install guide](https://github.com/boot-clj/boot#install) for more info.

Add this line to your application's Gemfile:

```ruby
gem 'cljs-rails'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cljs-rails

Run the generator
  
    $ bundle exec rails generate cljs_rails:install <optional app-name, defaults to the rails app name>

Bundle install again because the generator adds a new dependency (foreman)

    $ bundle

## Post-Install

Because the cljs build (powered by boot) needs to be run in parallel with the rails server, ``foreman`` was added to the gemfile and a basic ``Procfile`` that starts both these processes. So from now on instead of ``bundle exec rails server`` you should do:

    $ foreman start

> Because of the way clojure works the first time you start foreman (or run ``boot dev``) it will download all dependencies and also build your project. This is the equivalent, in webpack world, of doing both the ``npm install`` and ``webpack build``. Subsequent builds will not download depndencies and of course the dev tasks starts a watch that does hot-reloading and incremental builds (2k17).

Currently the bundle isn't loaded anywhere in your Rails app, you must add it to your layout using the ``cljs_main_path`` helper:

```erb
<%= javascript_include_tag cljs_main_path %>
```

After doing this you should navigate to an action and see clojurescript devtools messages in your browser console. 

Also, the generated core/main function injects "Hello world" into the document body. 
You can go to ``cljs/src/<app-name>/core.cljs`` and edit the text there. It should automagically recompile and run again in the browser! Yey!

## Production

There's a rake tasks provided ``cljs:compile`` that builds for production (with advanced optimisations).
It just runs ``boot #{production_task}``. Production task defaults to "prod" and is defined in the ``build.boot`` template, but you can configure it via ``config.cljs.production_build_task``.

The production build is configured by default to output to ``app/assets/cljs-build/``. This means that the sprockets can now find it.
The ``cljs_main_path`` helper will just return "main.js" when in production so sprokets will pickup the build file. In development/test it uses the dev-server settings.

You should add the precompile path to ``production.rb``:
```ruby
config.assets.precompile += [ 'main.js' ]
```

> By default ``app/assets/cljs-build`` is added to gitignore just in case, but you might want to (due to some limitations in your environemnt, but you shouldn't) commit your build artefacts to the repo.

#### Deployment to heroku

> WIP: Need to experiment with buildpacks and setup an example repo.

You can enhance the ``assets:precompile`` task so that it runs ``cljs:compile``. Add this to a rake file:

```ruby
Rake::Task['assets:precompile'].enhance ['cljs:compile']
```

Now as long as there's a proper buildpack being used that has ``boot`` installed, everything should work.

#### Custom deployment

Same logic as above should apply as long as you attach the compile task to run before ``assets:precompile``, and the server that's managing your build has ``boot`` setup.


## Notes

### Structure

The generator sets up a ``cljs`` folder with the source, a main and a namespace derived from the rails app name.

```
▾ cljs/
  ▾ src/
    ▾ <app-name>/
        core.cljs
      main.cljs.edn
```

> You can provide a different name as the first argument of the install generator.

## Prior art

- [webpack-rails](https://github.com/mipearson/webpack-rails)

## Contributing

1. Fork it ( https://github.com/[my-github-username]/cljs-rails/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
