require "ninesixty"

project_type = :rails

css_dir = (environment == :development) ? "public/stylesheets" : "tmp/stylesheets"
sass_dir = "app/assets/stylesheets"

output_style = (environment == :production) ? :compressed : :expanded

