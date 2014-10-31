require 'rails/generators'

class BlacklightSearchWithinGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  #require File.expand_path('../assets_generator.rb', __FILE__)
  def copy_public_assets
    #BlacklightSearchWithin::AssetsGenerator.start
  end

end
