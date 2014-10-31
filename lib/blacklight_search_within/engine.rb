require 'blacklight'
require 'blacklight_search_within'
require 'rails'

module BlacklightSearchWithin
  class Engine < Rails::Engine
  
    # Need to tell asset pipeline to precompile the excanvas
    # we use for IE. 
#    initializer "blacklight_search_within.assets", :after => "assets" do
#      Rails.application.config.assets.precompile += %w( flot/excanvas.min.js )
#    end
    
    # Do these things in a to_prepare block, to try and make them work
    # in development mode with class-reloading. The trick is we can't
    # be sure if the controllers we're modifying are being reloaded in
    # dev mode, if they are in the BL plugin and haven't been copied to
    # local, they won't be. But we do our best. 
    config.to_prepare do
      BlacklightSearchWithin.inject!
    end
  end
end
