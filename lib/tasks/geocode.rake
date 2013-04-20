task :geocode => :environment do
  require 'goog_geocoder'

  Hospital.find_each do |hospital|
    #next if hospital.geocode_accuracy # we've already geocoded
    puts "trying #{hospital.hospital_name}"
    goog = GoogGeocoder.new("#{hospital.address_1} #{hospital.address_2} #{hospital.address_3}, #{hospital.city}, #{hospital.state} #{hospital.zip_code}")
    if !goog.resp["results"].empty?
      accuracy = goog.resp["results"].first["geometry"]["location_type"] 
      if accuracy == "ROOFTOP" || accuracy == "RANGE_INTERPOLATED"
        geometry = goog.resp["results"].first["geometry"]["location"]
        hospital.lng           = geometry["lng"]
        hospital.lat           = geometry["lat"]
        hospital.save
        puts "updated #{hospital.hospital_name}: #{hospital.lat} #{hospital.lng} ☃"
      end
    end  
  end
end
