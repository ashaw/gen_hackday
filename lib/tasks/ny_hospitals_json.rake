task :json => :environment do
  hospitals = Hospital.where(:state => "NY", :county_name => ["NEW YORK", "KINGS", "QUEENS", "RICHMOND", "BRONX"])
  File.open("#{Rails.root.to_s}/db/initial/ny_hospitals.json", "w") do |f|
    f.write hospitals.to_json
  end
end