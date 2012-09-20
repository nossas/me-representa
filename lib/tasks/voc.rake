require 'open-uri'
require 'csv'

namespace :voc do
  desc "Import candidates from a remote csv file"
  task :import, [:url] => :environment do |t, args|
    CSV.parse(open(args.url, "r:UTF-8"), :headers => true) do |row|
      c = Candidate.find_or_create_by_number(
        row[2].to_i,
        :name => row[0].titleize, 
        :nickname => row[1] ? row[1].titleize : nil, 
        :number => row[2].to_i, 
        :email => row[5],
        :mobile_phone => row[6],
        :party => Party.find_or_create_by_symbol(row[9], :symbol => row[9], :union => Union.find_or_create_by_name(row[10], :name => row[10])),
        :male => row[13] == "Masculino" ? true : false,
        :born_at => row[14] ? Date.new(row[14].split("/")[2].to_i, row[14].split("/")[0].to_i, row[14].split("/")[1].to_i) : Date.new,
        :politician => !row[3].blank?,
        :occupation => row[15],
        :scholarity => row[16]
      )
      c.update_attributes(
        :name => row[0].titleize, 
        :nickname => row[1] ? row[1].titleize : nil, 
        :number => row[2].to_i, 
        :email => row[5],
        :mobile_phone => row[6],
        :party => Party.find_or_create_by_symbol(row[9], :symbol => row[9], :union => Union.find_or_create_by_name(row[10], :name => row[10])),
        :male => row[13] == "Masculino" ? true : false,
        :born_at => row[14] ? Date.new(row[14].split("/")[2].to_i, row[14].split("/")[0].to_i, row[14].split("/")[1].to_i) : Date.new,
        :politician => !row[3].blank?,
        :occupation => row[15],
        :scholarity => row[16]
      )
      puts c.persisted? ? "OK   #{c.name}" : "FAIL #{c.name} - #{c.errors.full_messages}"
    end
  end
end
