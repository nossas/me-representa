class City < ActiveRecord::Base
    attr_accessible :name, :state
    
    def self.cities_for_select
        City.order([:name, :state]).map {|c| ["#{c.name}, #{c.state}", c.id]}
    end
end
