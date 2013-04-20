task :import =>:environment do
  require 'csv'

  lookup = {
   "County Name"=>"county_name",
   "City"=>"city",
   "Address 1" => "address_1",
   "Address 2" => "address_2",
   "Address 3" => "address_3",
   "Provider Number"=>"provider_number",
   "ZIP Code"=>"zip_code",
   "State"=>"state",
   "Hospital Name" => "hospital_name",
   "Hospital 30-Day Death (Mortality) Rates from Heart Attack" => "heart_attack_mortality_rate"
 }  
  CSV.foreach("#{Rails.root.to_s}/db/initial/Hospital_Outcome_Of_Care_Measures.csv", :headers => true) do |row|
    h = Hospital.find_or_initialize_by_provider_number(row["Provider Number"])
    row.each do |k,v|
      next unless lookup[k]
      if (Hospital.columns_hash[lookup[k]].type == :integer || Hospital.columns_hash[lookup[k]].type == :float) && !v.blank?
        h[lookup[k]] = v.gsub(/\%/,"").to_f
      else
        h[lookup[k]] = v
      end
    end
    h.save
    p h
  end
end