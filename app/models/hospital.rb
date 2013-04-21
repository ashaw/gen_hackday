class Hospital < ActiveRecord::Base
   def self.nearest(lat, lng, dist = 1)
    Hospital.select("*, ST_Distance(ST_SetSRID(ST_MakePoint(lng, lat), 4326),ST_GeomFromText('POINT(#{lng.to_f} #{lat.to_f})', 4326))").
      where("ST_Distance(ST_SetSRID(ST_MakePoint(lng, lat), 4326),ST_GeomFromText('POINT(#{lng.to_f} #{lat.to_f})', 4326)) < #{dist.to_i}").
      order("st_distance").limit(10)
  end 
end