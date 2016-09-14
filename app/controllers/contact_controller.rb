
class ContactController < ApplicationController
    layout "merepresentalogged"
    
    include LoggedHelper;

    before_filter :load_logged

    def create
    end
    
    def show
    end
end