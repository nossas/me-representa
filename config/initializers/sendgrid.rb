if Rails.env.production?
  ActionMailer::Base.smtp_settings = {
    :address        => ENV['SENDGRID_URL'], # ex: 'smtp.sendgrid.net'
    :port           => ENV['SENDGRID_PORT'], # ex: '587'
    :authentication => :plain,
    :user_name      => ENV['SENDGRID_USERNAME'],
    :password       => ENV['SENDGRID_PASSWORD'],
    :domain         => ENV['SENDGRID_DOMAIN'] # ex: 'heroku.com'
  }
  ActionMailer::Base.delivery_method = :smtp
end
