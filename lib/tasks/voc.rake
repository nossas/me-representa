require 'open-uri'
require 'csv'

namespace :voc do
  desc "Import candidates from a remote csv file"
  task :import => :environment do
    CSV.parse(open("/Users/nicolas/Desktop/candidatos.csv", "r:UTF-8"), :headers => true) do |row|
      c = Candidate.find_or_create_by_number(
        row[2].to_i,
        :name => row[0].titleize, 
        :nickname => row[1] ? row[1].titleize : nil, 
        :number => row[2].to_i, 
        :email => row[4],
        :mobile_phone => row[5],
        :party => Party.find_or_create_by_symbol(row[8], :symbol => row[8], :union => Union.find_or_create_by_name(row[9], :name => row[9])),
        :male => row[12] == "Masculino" ? true : false,
        :born_at => row[13] ? Date.new(row[13].split("/")[2].to_i, row[13].split("/")[0].to_i, row[13].split("/")[1].to_i) : Date.new
      )
      puts c.persisted? ? "OK   #{c.name}" : "FAIL #{c.name} - #{c.errors.full_messages}"
    end
  end
end
