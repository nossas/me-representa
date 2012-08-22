require 'open-uri'
require 'csv'

namespace :voc do
  desc "Import candidates from a remote csv file"
  task :import => :environment do
    CSV.parse(open("/Users/nicolas/Desktop/candidatos.csv", "r:ISO-8859-1"), :headers => true) do |row|
      c = Candidate.find_or_create_by_number(
        row[2].to_i,
        :name => row[0].titleize, 
        :nickname => row[1].titleize, 
        :number => row[2].to_i, 
        :party => Party.find_or_create_by_number(row[5].to_i, :number => row[5].to_i, :symbol => row[4], :union => Union.find_or_create_by_name(row[6], :name => row[6])),
        :male => row[9] == "Masculino" ? true : false,
        :born_at => Date.new(row[10].split("-")[0].to_i, row[10].split("-")[1].to_i, row[10].split("-")[2].to_i)
      )
      puts c.persisted? ? "OK   #{c.name}" : "FAIL #{c.name} - #{c.errors.full_messages}"
    end
  end
end
