# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.assets.precompile += %w( magister.css )

Rails.application.config.assets.precompile += %w( bootstrap.min.css style.css toppage.css lesson_index.css lesson_show.css user_new.css session_new.css user_show.css user_edit.css message_index.css message_new message_show lesson_new.css lesson_edit.css point_new.css point_index.css withdraw_new.css password_resets_new.css password_resets_edit.css)