class MainController < ApplicationController
    layout "merepresentaunlogged"
    skip_authorization_check
    
    def index
    end
end