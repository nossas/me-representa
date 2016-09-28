# Me representa

## Requirements

* ruby 2.1.9
* rails 3.2.22.5

## Minimal Setup
Create a database config file at config/database.yml; you may use the config/database.sample.yml file as a starting point.

Use the bundle to install all the dependencies, as showed in example bellow:

> bundle install

To configure the facebook params, you must config this variables:
- FB_ID: Your Facebook app ID 
- FB_SECRET: Your App sercret key
Please refer to https://developers.facebook.com/ for more information about them.

In ubuntu linux you may configure them in your .bashrc file, located at your user's home dir as showed below:
> export FB_ID="12312312312"

> export FB_SECRET="SASDSEWEWEWFA"

Please refer your OS' environment variables section for more information.

For contacts, you must change the app/controllers/contact_controller.rb file, to reflect your project needs.

### Running in development 

To run the application, using Puma, one must use do: 

> bundle exec puma -C config/puma.rb

or you may run it using only rails:

> rails s

### Running in production

First step is to config the environment type (RACK_ENV) and the port number (PORT) variables , in linux you may do:

> export RACK_ENV="production"
> export PORT="80"

Please check out the config/puma.rb for more options/details

## History

Previously named "Verdade ou Consequência": Remember how good it was to play "Truth or Dare"? Now you can play with the candidates for councilor! These tool was developed and used during the year 2012.

Nowadays, the scope has been changed, now help our citizens to find politicians whom have human rights concerns are our primary goal. 
