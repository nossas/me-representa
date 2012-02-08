require "ninesixty"

project_type = :rails

css_dir = (environment == :production) ? "tmp/stylesheets" : "public/stylesheets"
sass_dir = "app/assets/stylesheets"

output_style = (environment == :production) ? :compressed : :expanded

