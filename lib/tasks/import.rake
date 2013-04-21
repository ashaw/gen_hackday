task :import =>:environment do
  require 'csv'

  sheets = ["Hospital_Outcome_Of_Care_Measures", "Hospital_Process_Of_Care_Measures_-_Heart_Attack"]

  lookups = [
  {
   "County Name"=>"county_name",
   "City"=>"city",
   "Address 1" => "address_1",
   "Address 2" => "address_2",
   "Address 3" => "address_3",
   "Provider Number"=>"provider_number",
   "ZIP Code"=>"zip_code",
   "State"=>"state",
   "Hospital Name" => "hospital_name",
   "Hospital 30-Day Death (Mortality) Rates from Heart Attack" => "heart_attack_mortality_rate",
   "Number of Patients - Hospital 30-Day Death (Mortality) Rates from Heart Attack" => "heart_attack_patients",   
 },
  {
  "Percent of Heart Attack Patients Given Aspirin at Discharge" => "asprin_at_discharge",
  "Outpatients with chest pain or possible heart attack who got aspirin within 24 hours of arrival" => "asprin_within_30min",
  "Percent of Heart Attack Patients Given Fibrinolytic Medication Within 30 Minutes Of Arrival" => "fibrinolytic_medication",
  "Percent of Heart Attack Patients Given PCI Within 90 Minutes Of Arrival" => "pci",
  "Average number of minutes before outpatients with chest pain or possible heart attack got an ECG" => "ecg",
  "Outpatients with chest pain or possible heart attack who got drugs to break up blood clots within 30 minutes of arrival" => "blood_clot_medication",
  "Median Time to Fibrinolysis" => "time_to_fibrinolysis",
 }
]

  0.upto(1).each do |i| 
    CSV.foreach("#{Rails.root.to_s}/db/initial/#{sheets[i]}.csv", :headers => true) do |row|
      h = Hospital.find_or_initialize_by_provider_number(row["Provider Number"])
      row.each do |k,v|
        next unless lookups[i][k]
        if (Hospital.columns_hash[lookups[i][k]].type == :integer || Hospital.columns_hash[lookups[i][k]].type == :float) && !v.blank?
          h[lookups[i][k]] = v.gsub(/\%/,"").to_f
        else
          h[lookups[i][k]] = v.strip
        end
      end
      h.save
      p h
    end
  end
end

task :ratings => :environment do 
  require 'csv'
  NY_AVG = 97.95
  CSV.foreach("#{Rails.root.to_s}/db/initial/hospital_game_data.csv", :headers => true) do |row|
    if row["ID"] && h = Hospital.find_or_initialize_by_provider_number(row["ID"])
      if row["Address 1"].to_s.length > 0
        # getting address from this sheet
        h.address_1 = row["Address 1"]
        h.city      = row["City"]
        h.state     = row["State"]
        h.zip_code  = row["Zip"]
        h.county_name = row["County"]
      end
      h.open = row["OPEN/CLOSED"] == "Open" ? true : false
      h.emergency_department = row["EMERGENCY DEPARTMENT"] == "Yes" ? true : false
      h.beds = row["AVAILABLE BEDS"].to_s.length > 0 ? row["AVAILABLE BEDS"].to_i : nil
      h.heart_care_rating = row["HEART CARE RATING"].to_s.length > 0 ? row["HEART CARE RATING"].to_f : nil
      if h.heart_care_rating && h.heart_care_rating > (NY_AVG + 0.5)
        h.hospital_rating_str = "Above average"
      elsif h.heart_care_rating && h.heart_care_rating < (NY_AVG - 0.5)
        h.hospital_rating_str = "Below average"
      elsif h.heart_care_rating
        h.hospital_rating_str = "About average"
      else
        h.hospital_rating_str = "Unknown"
      end
      h.save
      p h
    end
  end
end