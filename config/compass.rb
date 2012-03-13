require "ninesixty"

project_type = :rails

css_dir = "public/assets"
sass_dir = "app/assets/stylesheets"

output_style = (environment == :production) ? :compressed : :expanded

