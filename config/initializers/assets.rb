# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.precompile += %w( top.css )
Rails.application.config.assets.precompile += %w( items.css )
Rails.application.config.assets.precompile += %w( categories.css )
Rails.application.config.assets.precompile += %w( subcategories.css )
Rails.application.config.assets.precompile += %w( denominations.css )
Rails.application.config.assets.precompile += %w( conditions.css )
Rails.application.config.assets.precompile += %w( fabrics.css )
Rails.application.config.assets.precompile += %w( units.css )
Rails.application.config.assets.precompile += %w( item_types.css )
Rails.application.config.assets.precompile += %w( authorities.css )
Rails.application.config.assets.precompile += %w( administrators.css )
Rails.application.config.assets.precompile += %w( jquery.bxslider.css )
Rails.application.config.assets.precompile += %w( jquery.bxslider.min.js )
Rails.application.config.assets.precompile += %w( mosaic.css )
Rails.application.config.assets.precompile += %w( mosaic.1.0.1.min.js )
Rails.application.config.assets.precompile += %w( new_arrivals.css )
Rails.application.config.assets.precompile += %w( recommendations.css )
# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
